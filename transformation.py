import numpy as numpy
import pandas as pd
import copy
import sys
from io import StringIO
import os

#SET UP
FILE_PATH = 'ECI2002V-2020101215080000.spd.txt' #'Durst_TC9_18 RGB_updown.spd.txt'
if "RGB" in FILE_PATH or "rgb" in FILE_PATH:
    NUMBER_OF_SETS = 918
    LGOROWLENGTH = 27
else:
    NUMBER_OF_SETS = 1485 #918 RGB
    LGOROWLENGTH = 33 #height of the test chart 27 RGB

ALPH_NUM = ord('Z') - ord('A') + 1

def get_prepared_data_file(measurement_file_path):
    with open(measurement_file_path, mode='r') as f:
        lines = f.read()
        header = copy.deepcopy(lines).split("END_DATA_FORMAT")[0]
        final = copy.deepcopy(lines).split("BEGIN_DATA\n")[1].split('END_DATA')[0]
        f.close()
    
    return header, StringIO(final)

def get_transformed_character(el):
    lett = ''

    if int(el[1:]) > ALPH_NUM:
        lett = chr(ord('a') - 1 + int(el[1:]) - ALPH_NUM)
    else:
        lett = chr(ord('A') - 1 + int(el[1:]))
    return lett

def get_transformed_number(el):
    num = ''

    if ord(el[0]) <= ord('Z'):
        num = str(ord(el[0]) - ord('A') + 1)
    else:
        num = str(ALPH_NUM + ord(el[0]) - ord('a') + 1)
    
    if int(num) < 10:
        num = '0' + str(num)
    
    return num

def transform_data(prepared_data_file):
    df = pd.read_csv(prepared_data_file, sep="\t", header=None)
    df = df.drop(df.columns[0], axis=1)
    df_copy = copy.deepcopy(df)

    lett = ''
    num = ''
    for idx, el in enumerate(df[1]):
        lett = get_transformed_character(el)
        num = get_transformed_number(el)
        df_copy.iat[idx, 0] = lett + num

    df_copy.sort_values(1, inplace = True)
    df_copy.insert(0, 'id', range(1, len(df) + 1))
    return df_copy

def create_transformed_data_file(data_frame, header):
    filename_path = FILE_PATH.split('.txt')[0]
    data_frame.to_csv(filename_path + '_TEMP.txt', header=None, index=None, sep='\t', float_format='%.6f', mode='w')

    with open(filename_path + '_TEMP.txt', mode='r') as f:
        data = f.read()
        f.close()
    
    os.remove(filename_path + '_TEMP.txt')

    final_file_data = header + 'END_DATA_FORMAT\n\nNUMBER_OF_SETS      ' + str(NUMBER_OF_SETS) + '\nLGOROWLENGTH        ' + str(LGOROWLENGTH) + '\n\nBEGIN_DATA\n' + data + 'END_DATA'
    
    with open('1TransformedFiles/' + filename_path + '_Transformed.txt', mode='w') as f:
        f.write(final_file_data)
        f.close()

if __name__ == '__main__':
    header, prepared_data_file = get_prepared_data_file(FILE_PATH)
    data_frame = transform_data(prepared_data_file)
    create_transformed_data_file(data_frame, header)