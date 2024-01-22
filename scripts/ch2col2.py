import re
import sys
# def ch2col(inf_path):
#     try:
#         word_list = list()
#         with open(inf_path, 'r', encoding='utf8') as inf:
#             for line in inf:
#                 bur, eng = re.split(r'/', line.strip(), maxsplit=1)
#                 # bur, eng = re.split(r'\s+(?=[a-zA-z])', line.strip(), maxsplit=1)
#                 bur = re.split(' ', bur)
#                 eng = re.split(' ', eng)
                
#                 char_list = list()    
#                 for i, char in enumerate(bur):
#                     char_list.append((char, eng[i]))
                
#                 word_list.append(char_list)
#         return word_list
            
#     except FileNotFoundError:
#         print(f"Error: File '{inf_path}' not found.")


def ch2col(inf_path):
    try:
        with open(inf_path, 'r', encoding='utf8') as inf:   
            for line in inf:
                bur, eng = re.split(r'/', line.strip(), maxsplit=1)
                # bur, eng = re.split(r'\s+(?=[a-zA-z])', line.strip(), maxsplit=1)
                bur = re.split(' ', bur)
                eng = re.split(' ', eng)
                
                for i, char in enumerate(bur):
                    tup = (char, char, eng[i])
                    print(*tup)
                print('')
            
    except FileNotFoundError:
        print(f"Error: File '{inf_path}' not found.")


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: python ch2col2.py input_file')
        sys.exit(1)
    
    ch2col(sys.argv[1])