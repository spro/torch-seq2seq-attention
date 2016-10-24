snn = {}

-- Decoder
--
-- Currently only used for sampling while training, to provide a consistent interface
-- TODO: Use in actual training, add backward pass

local Decoder, parent = torch.class('snn.Decoder', 'nn.Module')

function Decoder:__init(clones)
    parent.__init(self)
    self.clones = clones
end

function Decoder:updateOutput(input)
    local t, decoder_input, last_h, encoder_outputs = unpack(input)
    local decoder_in_output = self.clones.decoder_in[t]:forward(decoder_input):view(-1)
    local decoder_gru_output = self.clones.decoder_gru[t]:forward({decoder_in_output, last_h, encoder_outputs})
    last_h = decoder_gru_output[1]
    last_a = decoder_gru_output[2]
    local decoder_output = self.clones.decoder_out[t]:forward(last_h)
    return {decoder_output, last_h, last_a}
end

-- StaticDecoder
--
-- Used for sampling from saved model, does not create clones or do backprop

local StaticDecoder, parent = torch.class('snn.StaticDecoder', 'nn.Module')

function StaticDecoder:__init(decoder_protos)
    parent.__init(self)
    self.decoder_protos = decoder_protos
end

function StaticDecoder:updateOutput(input)
    local t, decoder_input, last_h, encoder_outputs = unpack(input)
    local decoder_in_output = decoder_protos.decoder_in:forward(decoder_input):view(-1)
    local decoder_gru_output = decoder_protos.decoder_gru:forward({decoder_in_output, last_h, encoder_outputs})
    last_h = decoder_gru_output[1]
    last_a = decoder_gru_output[2]
    local decoder_output = decoder_protos.decoder_out:forward(last_h)
    return {decoder_output, last_h, last_a}
end

