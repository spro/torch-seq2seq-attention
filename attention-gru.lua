
function AttentionGRU(input_size, hidden_size, max_length)
    local input = nn.View(-1)()
    local prev_h = nn.View(-1)()
    local encs = nn.SplitTable(1)()
    local inputs = {input, prev_h, encs}

    local encs_sum = nn.View(-1)(nn.CAddTable()(encs))
    local attn_coef = nn.SoftMax()(nn.Linear(input_size + hidden_size * 2, max_length)(
        nn.JoinTable(1)({input, prev_h, encs_sum})))
    local attn = nn.MixtureTable()({attn_coef, encs})

    function makeGate(i, h)
        local i2h = nn.Linear(input_size, hidden_size)(i)
        local h2h = nn.Linear(hidden_size, hidden_size)(h)
        local a2h = nn.Linear(hidden_size, hidden_size)(attn)
        return nn.CAddTable()({i2h, h2h, a2h})
    end

    local z = nn.Sigmoid()(makeGate(input, prev_h))
    local r = nn.Sigmoid()(makeGate(input, prev_h))

    local reset_prev_h = nn.CMulTable()({r, prev_h})
    local h_candidate = nn.Tanh()(makeGate(input, reset_prev_h))

    local nz = nn.AddConstant(1)(nn.MulConstant(-1)(z))
    local zh = nn.CMulTable()({z, h_candidate})
    local nzh = nn.CMulTable()({nz, prev_h})
    local next_h = nn.CAddTable()({zh, nzh})

    local outputs = {next_h, attn_coef}
    return nn.gModule(inputs, outputs)
end

