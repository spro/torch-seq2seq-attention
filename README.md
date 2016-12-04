# torch-seq2seq-attention

This is a slightly modified implementation of [Neural Machine Translation by Jointly Learning to Align and Translate](https://arxiv.org/abs/1409.0473). It a feed-forward (not recurrent) encoder with a GRU based decoder with attention to translate the synthetic language *Espançanese*:

![](https://i.imgur.com/oEXlkQa.png)

## Model

This model builds upon [torch-seq2seq](https://github.com/spro/torch-seq2seq). In that model, the recurrent encoder outputs a single vector at the end (which represents the entire sentence) and the decoder decodes from there.

In this model the encoder does a single embedding transformation of input words to vectors; all vectors are then fed to the decoder. The decoder uses an attention mechanism to decide which of the context vectors to "focus on" at each time step (output word).

The attention mechanism builds upon the GRU (Gated Recurrent Unit) to create an AttentionGRU. The encoder context vectors are added as inputs at every step, and the current input and last hidden states are used to create attention weights. The attention weights are multiplied by encoder outputs and added to the final output state.

![](https://i.imgur.com/Ge50jI6.png)

The encoder is a single lookup table turning words into vectors of size `hidden_size`:

```lua
encoder = nn.LookupTable(n_tokens_in, hidden_size)
```

The decoder takes consists of three layers: an input lookup table, AttentionGRU, and a softmax output layer:

```lua
decoder_in = nn.LookupTable(n_tokens_out, hidden_size)

decoder_gru = AttentionGRU(hidden_size, hidden_size)

decoder_out = nn.Sequential()
    :add(nn.Linear(hidden_size, n_tokens_out))
    :add(nn.LogSoftMax())
```

## Training

```
$ th train.lua -hidden_size 100 -learning_rate 0.1

-hidden_size         Hidden size of GRU layer [200]
-learning_rate       Learning rate [0.001]
-learning_rate_decay Learning rate decay [1e-05]
-max_length          Maximum output length [20]
-n_epochs            Number of epochs to train [100000]
```

Every several iterations it will sample a new set of sentences and print them as:

```
> input
= target
~ output (sampled)
```

## Observations

My favorite part of the attention model is having something concrete to visualize and interpret.

### Using blind spots

The attention mechanism applies a fixed size softmax output to a fixed size encoder output, so there is necessarily a "blind spot" of zeros appended to encoder outputs to make them all the same size.

This particular model learned to something interesting with the "will not [verb]" translation, where it attends to the verb and negative partical (sen) at the same time, but then moves out of the sentence for a few steps. Since everything is zeroed this would effectively be "not paying attention" for the next few words and using those time steps to output a sequence that it has already built up.

![](https://i.imgur.com/kZGF4xJ.png)
![](https://i.imgur.com/c0RoHi4.png)

## Future work

In the non-attention model, the last step of the encoder does all the work by encoding the entire sentence into one vector. In this model the encoder is no longer recurrent, and each word has an independently calculated vector. It would be interesting to use two encoders, with attention over individual words guided by an overall context vector.
