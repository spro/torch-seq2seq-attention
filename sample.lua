require 'nn'
require 'rnn'
require 'nngraph'
display = require 'display'
image = require 'image'
require 'data'
require 'sampling'
require 'decoder'

encoder = torch.load('encoder.t7')
decoder_protos = torch.load('decoder.t7')
decoder = snn.StaticDecoder(decoder_protos)

-- Parse command line arguments

cmd = torch.CmdLine()
cmd:text()

cmd:option('-hidden_size', 200, 'Hidden size of GRU')
cmd:option('-max_length', 20, 'Maximum output length')
cmd:option('-sentence', '', 'Sentence to translate')

opt = cmd:parse(arg)

-- Sampling
--------------------------------------------------------------------------------

if opt.sentence ~= '' then
    sample(opt.sentence, '[user entered]')
else
    math.randomseed(os.time())
    randomSample()
end

