image = require 'image'

test = torch.zeros(5, 5)
test[1][2] = 1

-- Safer than image.scale because it won't introduce pixel artifacts

function drawBig(inp, size)
    img = torch.zeros(3, size, size)
    inp_size = inp:size(1)
    p = math.ceil(size / inp_size)
    for y = 1, inp_size do
        for x = 1, inp_size do
            c = inp[y][x] * 255
            img[{{}, {(y - 1) * p + 1, y * p}, {(x - 1) * p + 1, x * p}}] = c
        end
    end
    return img
end

