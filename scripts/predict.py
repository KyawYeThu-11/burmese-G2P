from sylbreak import break_text
from pathlib import Path
import re
import os

burmese_words_file = Path("burmese_words.txt")
    
def run_commands(commands):
    for command in commands:
        try:
            # Run the command using os.system
            return_code = os.system(command)

            # Check the return code
            if return_code != 0:
                print(f"Error running command: {command}")
                print(f"Return code: {return_code}")
        except Exception as e:
            print(f"Error running command: {command}")
            print(f"Exception: {e}")

def change_phonemes(burmese):
    # split the sentence into words
    if burmese_words_file.is_file():
        open(burmese_words_file, 'w').close()
        
    words = burmese.split(" ")
    
    with open(burmese_words_file, 'a') as f:
        for word in words:
            # trim spaces and pote-ma
            word = re.sub(r'[၊။\s]', '', word)
            # split the word into syllables
            separated_syl = break_text(word, " ").strip()
                        
            print(f"{separated_syl}/", end='', file=f)
            
            num_syl = len(separated_syl.split(" "))
            for i in range(num_syl):
                # if it's the last ?, attach a newline
                if i == range(num_syl)[-1]: print('?', file=f)
                else: print('? ', end='', file=f)
    
    commands = [
        "python3 ../scripts/ch2col2.py ./burmese_words.txt > ./burmese_words.txt.col",
        "cat burmese_words.txt.col | python3 ../crfsuite/chunking.py > predict",
        "crfsuite tag -m ./g2p.model ./predict > ./predict.out",
        "perl ../scripts/ch2line.pl ./predict.out > ./predict.out.line",
        # "rm ./burmese_words.txt.col ./predict ./predict.out"
        "rm ./burmese_words.txt ./burmese_words.txt.col ./predict ./predict.out"
        ]
    
    run_commands(commands)
    
    phonemes = ''
    with open('predict.out.line', 'r') as f:
        for line in f:
            phonemes += line.strip() + ' '
        
    
    run_commands(["rm ./predict.out.line"])            
    
    return phonemes.strip()

    
          
def main():
    while True:
        burmese = input("Enter a Burmese sentence: ")
        print(f"Phonemes of the sentence: {change_phonemes(burmese)}") 
        print('-----------------------------------------')
              
if __name__ == '__main__':
    main()