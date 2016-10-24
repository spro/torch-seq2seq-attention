require 'helpers'

genders = {
    m={
        the='el',
        a='un',
        my='me',
        your='te',
    },
    f={
        the='la',
        a='une',
        my='ma',
        your='ta',
    },
}

pronouns = {'the', 'my', 'your'}

nouns = {
    {'dog', 'perro', 'm'},
    {'cat', 'gato', 'm'},
    {'bird', 'pajaro', 'm'},
    {'goose', 'oca', 'f'},
    {'giraffe', 'jirafa', 'f'},
    {'jellyfish', 'medusa', 'f'},
    {'hedgehog', 'erizo', 'm'},
    {'cricket', 'grillo', 'm'},
    {'computer', 'computadora', 'f'},
    {'door', 'puerta', 'f'},
    {'window', 'ventana', 'f'},
    {'table', 'mesa', 'f'},
    {'chair', 'silla', 'f'},
    {'head', 'cabeza', 'f'},
    {'brain', 'cerebro', 'm'},
    {'hair', 'pelo', 'm'},
    {'face', 'cara', 'f'},
    {'mouth', 'boca', 'f'},
    {'shoulder', 'hombro', 'm'},
    {'shoe', 'zapato', 'm'},
    {'glove', 'guante', 'm'},
    {'hat', 'sombrero', 'm'},
    {'scarf', 'panuelo', 'm'},
    {'shirt', 'camisa', 'f'},
    {'knife', 'cuchillo', 'm'},
    {'book', 'libro', 'm'},
    {'garden', 'jardin', 'm'},
    {'boat', 'barco', 'm'},
    {'desk', 'escritorio', 'm'},
    {'box', 'caja', 'f'},
    {'steak', 'bistec', 'm'},
    {'salad', 'ensalada', 'f'},
    {'lemon', 'limon', 'm'},
    {'apple', 'manzana', 'f'},
    {'rum', 'ron', 'm'},
    {'beer', 'cerveza', 'm'},
}

adjs = {
    {'blue', 'bleu'},
    {'green', 'verde'},
    {'red', 'rouge'},
    {'black', 'noir'},
    {'white', 'blanc'},
    {'small', 'petit'},
    {'large', 'grand'},
    {'soft', 'doux'},
    {'healthy', 'sain'},
    {'dirty', 'sal'},
    {'lazy', 'paresseux'},
    {'nervous', 'nerveux'},
    {'sad', 'triste'},
    {'cold', 'froid'},
    {'evil', 'mechant'},
    {'new', 'noveau'},
    {'heavy', 'lourd'},
    {'slow', 'lent'},
    {'silent', 'silencieux'},
}

advs = {
    {'clearly', 'clairement'},
    {'slowly', 'lentement'},
    {'silently', 'silencieusement'},
    {'clumsily', 'maladriotement'},
    {'courageously', 'courageusement'},
    {'fearfully', 'craintivement'},
    {'intellegently', 'intelligemment'},
    {'politely', 'poliment'},
    {'quickly', 'vite'},
    {'well', 'bien'},
    {'badly', 'mal'},
    {'elegantly', 'elegamment'},
    {'a lot', 'beaucoup'},
    {'enough', 'assez'},
}

vintr_presents = {
    {'standing', 'tatte'},
    {'drinking', 'nonde'},
    {'running', 'hashitte'},
    {'jogging', 'jogingu shite'},
    {'talking', 'hanashite'},
    {'reading', 'yonde'},
    {'swimming', 'oyoide'},
    {'waiting', 'matte'},
    {'sleeping', 'matte'},
}

vintr_pasts = {
    {'sang', 'utatta'},
    {'drank', 'nonda'},
    {'flew', 'tonda'},
    {'escaped', 'nigeta'},
    {'bathed', 'abita'},
    {'laughed', 'waratta'},
    {'swam', 'oyoida'},
    {'called', 'yonda'},
    {'waited', 'matta'},
    {'ate', 'tabeta'},
    {'slept', 'neta'},
}

vintr_futures = {
    {'eat', 'taberu'},
    {'drink', 'nomu'},
    {'fly', 'tobu'},
    {'run', 'hashiru'},
    {'talk', 'hanasu'},
    {'bathe', 'abiru'},
    {'laugh', 'warau'},
    {'ponder', 'omoiiru'},
    {'swim', 'oyogu'},
    {'call', 'yobu'},
    {'sleep', 'neru'},
}

vtr_presents = {
    {'kicking', 'kette'},
    {'eating', 'tabete'},
    {'flying', 'tonde'},
    {'drawing', 'kaite'},
    {'grilling', 'yaite'},
    {'reading', 'yonde'},
    {'seeing', 'mite'},
    {'protecting', 'mamotte'},
}

vtr_pasts = {
    {'kicked', 'ketta'},
    {'ate', 'tabeta'},
    {'grilled', 'yaita'},
    {'called', 'yaita'},
    {'saw', 'mita'},
    {'bought', 'katta'},
    {'crushed', 'kudaita'},
    {'protected', 'mamotta'},
    {'drank', 'nonda'},
}

vtr_futures = {
    {'kick', 'keru'},
    {'cut', 'kiru'},
    {'eat', 'taberu'},
    {'grill', 'yaku'},
    {'avoid', 'sakeru'},
    {'drink', 'nomu'},
    {'see', 'miru'},
    {'comfort', 'nagusameru'},
    {'hug', 'daku'},
    {'inhale', 'suu'},
    {'mock', 'yajiru'},
    {'protect', 'mamoru'},
}

sentences = {
    {'i am $vintr_present', 'watashi wa $vintr_present iru'},
    {'i am definitely $vintr_present', '! watashi wa $vintr_present iru !'},
    {'i am $vintr_present $adv', 'watashi wa $adv $vintr_present iru'},
    {'i am definitely $vintr_present $adv', '! watashi wa $adv $vintr_present iru !'},
    {'am i $vintr_present ?', '? watashi wa $vintr_present iru ka ?'},
    {'are you $vintr_present ?', '? anata wa $vintr_present iru ka ?'},

    {'i am $vtr_present $noun', '$noun wo $vtr_present iru'},
    {'you are $vtr_present $noun', 'anata wa $noun o $vtr_present iru'},
    {'i $vtr_past $noun', '$noun wo $vtr_past'},
    {'you $vtr_past $noun', 'anata wa $noun o $vtr_past'},
    {'i $vtr_past $noun and $noun2', '$noun et $noun2 wo $vtr_past'},
    {'i will $vtr_future $noun', '$noun wo $vtr_future'},
    {'i will $vtr_future $noun and $noun2', '$noun et $noun2 wo $vtr_future'},
    {'i will definitely $vtr_future $noun', '! $noun wo $vtr_future !'},
    {'i will not $vtr_future $noun', '$noun wo $vtr_future sen'},
    {'i will not $vtr_future $noun or $noun2', '$noun ou $noun2 wo $vtr_future sen'},
    {'i definitely will not $vtr_future $noun', '! $noun wo $vtr_future sen !'},

    {'$noun is $vintr_present', '$noun wa $vintr_present iru'},
    {'is $noun $vintr_present ?', '? $noun wa $vintr_present iru ka ?'},
    {'$noun is $vintr_present $adv', '$noun wa $adv $vintr_present iru'},
    {'is $noun $vintr_present $adv ?', '? $noun wa $adv $vintr_present iru ka ?'},
    {'$noun will $vintr_future', '$noun wa $vintr_future'},
    {'$noun $vintr_past', '$noun wa $vintr_past'},
    {'$noun $vtr_past $noun2', '$noun wa $noun2 o $vtr_past'},
    {'$noun $vtr_past $noun2 $adv', '$noun wa $noun2 o $adv $vtr_past'},

    {'this is $noun', 'kore wa $noun desu'},
    {'this is not $noun', 'kore wa $noun arimasen'},
    {'this is definitely $noun', '! kore wa $noun desu !'},
    {'this is definitely not $noun', '! kore wa $noun arimasen !'},

    {'where is $noun ?', '? $noun wa doko desu ka ?'},
    {'is this $noun ?', '? kore wa $noun desu ka ?'},
    {'is this $noun or $noun2 ?', '? kore wa $noun ou $noun2 desu ka ?'},
    {'isnt this $noun ?', '? kore wa $noun desu ne ?'},
    {'who $vtr_past $noun ?', '? dare ga $noun o $vtr_past ka ?'},
    {'who $vtr_past $noun and $noun2 ?', '? dare ga $noun et $noun2 o $vtr_past ka ?'},
    {'who is $vtr_present $noun ?', '? dare ga $noun o $vtr_present iru nodesu ka ?'},
}

function contains(l, val)
    for i = 1, #l do
        if l[i] == val then 
            return true
        end
    end
    return false
end

function maybeInsert(l, val)
    if not contains(l, val) then
        table.insert(l, val)
    end
end

all_words_in = tokenize('the a my your his her')
all_words_out = tokenize('el la un une me ma te ta')

function addAll(list)
    for i = 1, #list do
        local in_tokens = tokenize(list[i][1])
        local out_tokens = tokenize(list[i][2])
        for t = 1, #in_tokens do
            local in_token = in_tokens[t]
            if string.match(in_token, '^%$') == nil then
                maybeInsert(all_words_in, in_token)
            end
        end
        for t = 1, #out_tokens do
            local out_token = out_tokens[t]
            if string.match(out_token, '^%$') == nil then
                maybeInsert(all_words_out, out_token)
            end
        end
    end
end

addAll(sentences)
addAll(nouns)
addAll(vintr_presents)
addAll(vintr_pasts)
addAll(vintr_futures)
addAll(vtr_presents)
addAll(vtr_pasts)
addAll(vtr_futures)
addAll(adjs)
addAll(advs)

shuffleTable(all_words_in)
shuffleTable(all_words_out)

-- FLIP
all_words_in, all_words_out = all_words_out, all_words_in

function makeInverse(list)
    local inverse = {}
    for i = 1, #list do
        inverse[list[i]] = i
    end
    return inverse
end
all_words_in_inverse = makeInverse(all_words_in)
all_words_out_inverse = makeInverse(all_words_out)

n_words_in = #all_words_in
n_words_out = #all_words_out

function randomChoice(l)
    return l[math.ceil(math.random() * #l)]
end

function randomNoun()
    local pronoun_base = randomChoice(pronouns)
    local has_adj = math.random() < 0.3
    local noun = randomChoice(nouns)
    local gendered = genders[noun[3]]
    local in_noun = ''
    local out_noun = ''
    if has_adj then
        local adj = randomChoice(adjs)
        in_noun = string.format('%s %s %s', pronoun_base, adj[1], noun[1])
        out_noun = string.format('%s %s %s', gendered[pronoun_base], noun[2], adj[2])
    else
        in_noun = string.format('%s %s', pronoun_base, noun[1])
        out_noun = string.format('%s %s', gendered[pronoun_base], noun[2])
    end
    return {in_noun, out_noun}
end

function makeSentence()
    local sentence = randomChoice(sentences)
    local in_sentence = sentence[1]
    local out_sentence = sentence[2]

    local noun = randomNoun()
    local noun2 = randomNoun()
    local adv = randomChoice(advs)

    local vtr_present = randomChoice(vtr_presents)
    local vtr_past = randomChoice(vtr_pasts)
    local vtr_future = randomChoice(vtr_futures)
    local vintr_present = randomChoice(vintr_presents)
    local vintr_past = randomChoice(vintr_pasts)
    local vintr_future = randomChoice(vintr_futures)

    in_sentence = string.gsub(in_sentence, '$noun2', noun2[1])
    out_sentence = string.gsub(out_sentence, '$noun2', noun2[2])
    in_sentence = string.gsub(in_sentence, '$noun', noun[1])
    out_sentence = string.gsub(out_sentence, '$noun', noun[2])
    in_sentence = string.gsub(in_sentence, '$adv', adv[1])
    out_sentence = string.gsub(out_sentence, '$adv', adv[2])
    in_sentence = string.gsub(in_sentence, '$vtr_past', vtr_past[1])
    out_sentence = string.gsub(out_sentence, '$vtr_past', vtr_past[2])
    in_sentence = string.gsub(in_sentence, '$vtr_present', vtr_present[1])
    out_sentence = string.gsub(out_sentence, '$vtr_present', vtr_present[2])
    in_sentence = string.gsub(in_sentence, '$vtr_future', vtr_future[1])
    out_sentence = string.gsub(out_sentence, '$vtr_future', vtr_future[2])
    in_sentence = string.gsub(in_sentence, '$vintr_past', vintr_past[1])
    out_sentence = string.gsub(out_sentence, '$vintr_past', vintr_past[2])
    in_sentence = string.gsub(in_sentence, '$vintr_present', vintr_present[1])
    out_sentence = string.gsub(out_sentence, '$vintr_present', vintr_present[2])
    in_sentence = string.gsub(in_sentence, '$vintr_future', vintr_future[1])
    out_sentence = string.gsub(out_sentence, '$vintr_future', vintr_future[2])
    -- return {in_sentence, out_sentence}
    return {out_sentence, in_sentence}
end

function outToWord(wi)
    return all_words_out[wi]
end

function wordToIn(word)
    return all_words_in_inverse[word]
end

function wordToOut(word)
    return all_words_out_inverse[word]
end

SOS = n_words_out + 1
EOS = n_words_out + 2
n_tokens_out = n_words_out + 2
-- Input and output functions

seen_inputs = {}

function makeEncoderInputs(tokens)
    local inputs = {}
    local joined = table.concat(tokens, ' ')
    local had_seen = seen_inputs[joined]
    seen_inputs[joined] = true
    for ci = 1, #tokens do
        table.insert(inputs, wordToIn(tokens[ci]))
    end
    return torch.Tensor(inputs):view(-1, 1), not had_seen
end

function makeDecoderInput(word)
    return torch.LongTensor({word})
end

function makeDecoderInputs(tokens)
    local word_inputs = {}
    table.insert(word_inputs, SOS)
    for ci = 1, #tokens do
        local word = tokens[ci]
        table.insert(word_inputs, wordToOut(word))
    end
    return torch.LongTensor(word_inputs):view(-1, 1)
end

function makeDecoderTargets(tokens)
    local inputs = {}
    for ci = 1, #tokens do
        table.insert(inputs, wordToOut(tokens[ci]))
    end
    table.insert(inputs, EOS)
    return torch.LongTensor(inputs):view(-1, 1)
end

