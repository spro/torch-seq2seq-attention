function map(list, fn)
    local mapped = {}
    for i = 1, #list do
        mapped[i] = fn(list[i])
    end
    return mapped
end

function shuffleTable(t)
    local iterations = #t
    local j

    for i = iterations, 2, -1 do
        j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

function tokenize(s)
    local tokens = {}
    for i in string.gmatch(s, '%S+') do
        table.insert(tokens, i)
    end
    return tokens
end
