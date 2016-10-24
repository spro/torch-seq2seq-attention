print('--------------------------------------------------------------------------------')
require 'nn'
require 'dpnn'
require 'optim'
require 'nngraph'
model_utils = require 'model_utils'
display = require 'display'
require 'data'
require 'attention-gru'
require 'sampling'
require 'decoder'

-- Parse command line arguments

cmd = torch.CmdLine()
cmd:text()

cmd:option('-hidden_size', 200, 'Hidden size of GRU layer')
cmd:option('-learning_rate', 0.001, 'Learning rate')
cmd:option('-learning_rate_decay', 1e-5, 'Learning rate decay')
cmd:option('-max_length', 20, 'Maximum output length')
cmd:option('-n_epochs', 100000, 'Number of epochs to train')

opt = cmd:parse(arg)

-- Build the model

encoder = nn.LookupTable(n_words_in, opt.hidden_size)

decoder_in = nn.Sequential()
    :add(nn.LookupTable(n_tokens_out, opt.hidden_size))

decoder_out = nn.Sequential()
    :add(nn.Linear(opt.hidden_size, n_tokens_out))
    :add(nn.LogSoftMax())

-- Clone and flatten decoder models

local protos = {
    decoder_gru = AttentionGRU(opt.hidden_size, opt.hidden_size, opt.max_length),
    decoder_in = decoder_in,
    decoder_out = decoder_out,
    criterion = nn.ClassNLLCriterion()
}
local params, grad_params = model_utils.combine_all_parameters(encoder, protos.decoder_gru, protos.decoder_in, protos.decoder_out)
params:uniform(-0.08, 0.08)

local clones = {}
for name, proto in pairs(protos) do
    clones[name] = model_utils.clone_many_times(proto, opt.max_length)
end

decoder = snn.Decoder(clones)

randomSample()

-- Training
--------------------------------------------------------------------------------

-- Run a loop of optimization

n_epoch = 1

function feval(params_)
    if params_ ~= params then
        params:copy(params_)
    end
    grad_params:zero()
	encoder:zeroGradParameters()

    -- Inputs and targets

	local sentence = makeSentence()
    local input_tokens = tokenize(sentence[1])
    local output_tokens = tokenize(sentence[2])

    local encoder_inputs = makeEncoderInputs(input_tokens)
    local decoder_inputs = makeDecoderInputs(output_tokens)
    local decoder_targets = makeDecoderTargets(output_tokens)

	-- Forward pass

	local encoder_outputs = encoder:forward(encoder_inputs)
    local last_index = encoder_outputs:size()[1]
    encoder_outputs = torch.cat(encoder_outputs, torch.zeros(opt.max_length - last_index, 1, opt.hidden_size), 1)
    
    local decoder_in_outputs = {}
    local decoder_outputs = {}
    local hs = {[0] = torch.zeros(opt.hidden_size)}
    local loss = 0

    for t = 1, #output_tokens + 1 do
        decoder_in_outputs[t] = clones.decoder_in[t]:forward(decoder_inputs[t])
        hs[t] = clones.decoder_gru[t]:forward({decoder_in_outputs[t], hs[t-1], encoder_outputs})[1]
        decoder_outputs[t] = clones.decoder_out[t]:forward(hs[t])

        loss = loss + clones.criterion[t]:forward(decoder_outputs[t], decoder_targets[t])
    end

	-- Backward pass

    local d_ins = {}
    local d_hs = {}
    local d_outs = {}
    local dencs = torch.zeros(opt.max_length, 1, opt.hidden_size)
    for t = #output_tokens + 1, 1, -1 do
        d_outs[t] = clones.criterion[t]:backward(decoder_outputs[t], decoder_targets[t])
        d_hs[t] = clones.decoder_out[t]:backward(hs[t], d_outs[t])
        din, d_hs[t-1], denc = unpack(clones.decoder_gru[t]:backward(
            {input[{t}], hs[t-1], encoder_outputs},
            {d_hs[t], torch.zeros(opt.max_length)}
        ))
        dencs:add(denc)
        clones.decoder_in[t]:backward(decoder_inputs[t], din)
    end

    -- Summed encoder gradients
	encoder:backward(encoder_inputs, dencs[{{1, last_index}}])

	return loss / #output_tokens, grad_params
end

losses = {}
loss_sofar = 0
learning_rates = {}
plot_every = 10
sample_every = 500
save_every = 10000

optim_state = {
    learningRate = opt.learning_rate,
    learningRateDecay = opt.learning_rate_decay
}

function save()
    torch.save('encoder.t7', encoder)
    torch.save('decoder.t7', protos)
end

for n_epoch = 1, opt.n_epochs do
    local _, loss = optim.adam(feval, params, optim_state)
    loss_sofar = loss_sofar + loss[1]

    -- Plot every plot_every
    if n_epoch % plot_every == 0 then
        if loss_sofar > 0 and loss_sofar < 999 then
            table.insert(losses, {n_epoch, loss_sofar / plot_every})
            display.plot(losses, {win='dec losses 4'})
        end
        loss_sofar = 0
    end

    -- Sample every sample_every
    if n_epoch % sample_every == 0 then
        randomSample()
    end

    -- Save every save_every
    if n_epoch % save_every == 0 then
        save()
    end
end
