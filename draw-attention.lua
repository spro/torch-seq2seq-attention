require 'scale-image'

function showLabeledAttentions(attentions, input_tokens, sampled_tokens)
    p = 25
    w = attentions:size()[1]
    sw = 200
    fw = w * p
    a_img = drawBig(all_a, w*p, 'a') -- Non-artifact scaling

    blue = {0, 0, 255}
    purple = {255, 19, 255}
    light_gray = 242
    top_offset = 2
    left_offset = 8
    text_size=2

    -- Top text (input)
    tww = #input_tokens * p
    ptw = math.max(tww, sw)
    local top_words = torch.ones(3, ptw, ptw):fill(255)
    for oi = 1, #input_tokens do
        top_words = image.drawText(top_words, input_tokens[oi], left_offset, p * (oi - 1) + top_offset, {color=blue, size=text_size, wrap=false})
    end
    top_words = image.rotate(top_words, math.pi/2)
    top_words = top_words[{{}, {ptw - sw + 1, ptw}, {1, tww}}]

    -- Side text (output)
    swh = #sampled_tokens * p
    local side_words = torch.zeros(3, swh, sw):fill(255)
    for oi = 1, #sampled_tokens do
        side_words = image.drawText(side_words, sampled_tokens[oi], left_offset, p * (oi - 1) + top_offset, {color=purple, size=text_size, wrap=false})
    end

    -- Put all the images together
    a_img_labeled = torch.zeros(3, sw + swh, fw + sw):fill(light_gray)
    a_img_labeled[{{1,3}, {1, sw}, {sw + 1, tww + sw}}] = top_words
    a_img_labeled[{{1,3}, {sw + 1, sw + swh}, {1, sw}}] = side_words
    a_img_labeled[{{}, {sw + 1, sw + swh}, {sw + 1, fw + sw}}] = a_img[{{}, {1, swh}, {}}]

    display.image(a_img_labeled, {win='aimg'})
end

