import re

myConsonant = r"က-အ၎"
enChar = r"a-zA-Z0-9"
otherChar = r"ဣဤဥဦဧဩဪဿ၌၍၏၀-၉၊။!-/:-@[-`{-~\s"
ssSymbol = r'္'
aThat = r'်'

#Regular expression pattern for Myanmar syllable breaking
#*** a consonant not after a subscript symbol AND a consonant is not followed by a-That character or a subscript symbol
BreakPattern = re.compile(r"((?<!" + ssSymbol + r")["+ myConsonant + r"](?![" + aThat + ssSymbol + r"])" + r"|[" + enChar + otherChar + r"])")


def _break_syllable(text, sOption):
   '''
   Break a given line of text into syllables
   '''
   # remove spaces and newlines
   text = re.sub('\s+', '', text)

   # ensure a-That character(်) comes before out-ka-myint(့) symbol
   text = re.sub('့်', '့်', text)

   # start breaking
   text = BreakPattern.sub(sOption + r"\1", text)
   
   return text

def break_text(text, sOption):
   '''
   Break text into syllables
   '''
   data = ""

   data += _break_syllable(text, sOption)
   
   return data


def break_file(file, sOption):
   '''
   Break a text file into syllables
   '''
   data = ""

   with open(file, encoding='utf-8') as file:
      for line in file:
         data += _break_syllable(line, sOption)
   
   return data