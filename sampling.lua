require 'draw-attention'

function sample(sentence, target)
    local input_tokens = tokenize(sentence)

    local encoder_inputs = makeEncoderInputs(input_tokens)
    local encoder_outputs = encoder:forward(encoder_inputs)
    local last_index = encoder_outputs:size()[1]

    -- Start with start marker
    local decoder_input = makeDecoderInput(SOS)
    local sampled = ''

    -- local last_h = encoder_outputs[last_index]:view(-1)
    local last_h = torch.zeros(opt.hidden_size)
    encoder_outputs = torch.cat(encoder_outputs, torch.zeros(opt.max_length - last_index, 1, opt.hidden_size), 1)

    all_a = torch.zeros(opt.max_length, opt.max_length)

    sampled_tokens = {}
    for t = 1, opt.max_length do
        decoder_output, last_h, last_a = unpack(decoder:forward({t, decoder_input, last_h, encoder_outputs}))
        all_a[{t, {}}] = last_a

        -- Get most likely output
        local max_score, max_val = decoder_output:view(-1):max(1)
        max_val = max_val[1]

        if max_val == EOS then
            table.insert(sampled_tokens, '<EOS>')
            break
        else
            -- Next input is this output
            decoder_input = makeDecoderInput(max_val)
            sampled_token = outToWord(max_val)
            table.insert(sampled_tokens, sampled_token)
            sampled = sampled .. sampled_token .. ' '
        end
    end

    showLabeledAttentions(all_a, input_tokens, sampled_tokens)

    print(string.format('\n> %s\n= %s\n~ %s', sentence, target, sampled))
    return sampled
end

function randomSample()
    sentence, target = unpack(makeSentence())
    sample(sentence, target)
end


