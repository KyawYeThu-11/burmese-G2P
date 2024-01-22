# myG2P

Myanmar (Burmese) Language Grapheme to Phoneme Converter for automatic speech recognition (ASR) and text-to-speech (TTS) using [myG2P Dictionary from the repository by ye-kyaw-thu](https://github.com/ye-kyaw-thu/myG2P).

## Lincense

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a>

Creative Commons Attribution-NonCommercial-Share Alike 4.0 International (CC BY-NC-SA 4.0) License  
[Details Info of License](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Introduction

Training process in deep learning approaches to ASR and TTS has become more end-to-end over a past few decades (eg. [Tacotron2](https://arxiv.org/abs/1712.05884)), eliminating the need to extract intricate linguistic features from the text. However, since this simiplicity instead requires a large amount of data, it can be a bottleneck for low-resource languages like Burmese. Recent TTS approaches that are claimed to yield human-level quality like [NaturalSpeech](!https://speechresearch.github.io/naturalspeech/) also still require phonemes as one of their inputs instead of transcripts. Indeed, the G2P converter inside `ver2` folder is developed to be used as an upstream module for NaturalSpeech, but both G2P converters provided here can also be used for any other relevant purposes.

## Directory structure

Here are a few important files:

```
myG2P/
├── crfsuite/
│ ├── chunking.py
├── scripts/
│ ├── preprocess.sh
│ ├── evaluate.sh
│ ├── predict.py
├── tutorial/
│ ├── tutorial.pdf
├── ver1/
│ ├── g2p.model
│ ├── myg2p.ver1.txt
├── ver2/
│ ├── g2p.model
│ ├── myg2p.ver2.0.txt
├── README.md
```

- `crfsuite`: G2P converters here are trained using a popular graphical model for sequence lebeling named [CRF (Conditional Random Field)](!https://en.wikipedia.org/wiki/Conditional_random_field), and a CRF toolkit named [CRFSuite](http://www.chokkan.org/software/crfsuite/) is used to apply the model.
- `scripts`: Running `preprocess.sh` will create training and testing data ready to be immediately used for training the model. Running `evaluate.sh` will output the accuracy of the model or its prediction for the testing data depending on the option provided. Running `predict.py` will allow users to input any Burmese text and output its phoneme.
- `ver1`: `g2p.model` is a functioning model trained on `myg2p.ver1.txt` that outputs phonemes given a sentence or words. The phonemes are spelt in English intuitively, which is not a standardized way and somewhat similar to Myanglish (Burmese Language but spelled out using the English alphabet).
  ```
  သဘာဝပတ်​ဝန်းကျင်​၏ ဆန့်ကျင်ဘက်အရာသည် လုပ်ယူဖန်တီးထားသော ပတ်​ဝန်းကျင်​ဖြစ်​သည်​။ -> dha- ba wa. bjo_ wun_ kyin gyin za- kyin be' a- ja dhi lou' ju hpan ti_ hta_ dho_ ba- wun_ dha- din_ ga_
  ```
- `ver2`: `g2p.model` is a functioning model trained on `myg2p.ver2.0.txt` that outputs phonemes given a sentence or words. The phonemes are spelt in [IPA (International Phonetic Alphabet)](!https://www.internationalphoneticassociation.org/content/full-ipa-chart), which is the ideal format for NaturalSpeech.
  ```
  သဘာဝပတ်​ဝန်းကျင်​၏ ဆန့်ကျင်ဘက်အရာသည် လုပ်ယူဖန်တီးထားသော ပတ်​ဝန်းကျင်​ဖြစ်​သည်​။ -> ðə bà wa̰ pʰó wʊ́ɴ zə gá zə tɕɪ̀ɴ bɛʔ ʔə jà ðì loʊʔ jù pʰàɴ tí tʰá ðɔ́ bə wʊ́ɴ kə lə baʔ
  ```

## Installation and Usage

Procedures for installing CRFSuite, training and evaluation are documented in this [notion page](!https://www.notion.so/yethu/Tutorial-for-Burmese-G2P-Converter-70edda56bb244fa2ba88498bb06cbd5f). Some procedures from the [original tutorial](!https://github.com/ye-kyaw-thu/myG2P/blob/master/tutorial/g2p-tutorial.pdf) are automated and some installation steps for CRFSuite have been modified to reflect the current state of the software distribution.

## Acknowledgement

The development of these Burmese G2P converters can be largely attributable to the G2P dictionary for training and tutorials provided by Mr. Ye Kyaw Thu, and the repository hosting them can be found [here](!https://github.com/ye-kyaw-thu/myG2P).

## Future Developments

- Incorporating sentence level conversion (Current model predicts incorrect phonemes for characters not included in nouns, verbs, and adjectives such as particles and post-positional markers)
- Changing burmese digits into words
