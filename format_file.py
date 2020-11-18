import numpy as numpy
import pandas as pd
import copy
import sys
from io import StringIO
import os

#SET UP
MATLAB_FILE_PATH = '2CalculatedXYZLAB\Durst_eci2002v_cmyk_d50_31.txt' #CHECK THAT THIS TWO BE THE SAME
TRANSFORMED_FILE_PATH = '1TransformedFiles/ECI2002V_updown.spd_Transformed.txt'
TEST_CHART = MATLAB_FILE_PATH.split('_')[1]
MEASUREMENT_TYPE = MATLAB_FILE_PATH.split('_')[2]
OBSERVER = MATLAB_FILE_PATH.split('_')[3] + '_' + MATLAB_FILE_PATH.split('_')[4]
if TEST_CHART == 'tc918':
    NUMBER_OF_SETS = 918
    LGOROWLENGTH = 27
    REFERENCE_FILE_PATH = r'NTNU\Reference files\TC9.18 RGB.txt'
    NUMBER_OF_FIELDS = 11
elif TEST_CHART == 'eci2002v':
    NUMBER_OF_SETS = 1485
    LGOROWLENGTH = 33
    REFERENCE_FILE_PATH = r'NTNU\Reference files\ECI2002V CMYK.txt'
    NUMBER_OF_FIELDS = 12
elif TEST_CHART == 'eci2002r':
    NUMBER_OF_SETS = 1485
    LGOROWLENGTH = 33
    REFERENCE_FILE_PATH = r'NTNU\Reference files\ECI2002R CMYK.txt'
    NUMBER_OF_FIELDS = 12

if NUMBER_OF_FIELDS == 11:
    DATA_FORMAT = 'KEYWORD\t"SampleID"\nKEYWORD\t"SAMPLE_NAME"\nBEGIN_DATA_FORMAT\nSampleID\tSAMPLE_NAME\tRGB_R\tRGB_G\tRGB_B\tXYZ_X\tXYZ_Y\tXYZ_Z\tLAB_L\tLAB_A\tLAB_B\nEND_DATA_FORMAT'
else:
    DATA_FORMAT = 'KEYWORD\t"SampleID"\nKEYWORD\t"SAMPLE_NAME"\nBEGIN_DATA_FORMAT\nSampleID\tSAMPLE_NAME\tCMYK_C\tCMYK_M\tCMYK_Y\tCMYK_K\tXYZ_X\tXYZ_Y\tXYZ_Z\tLAB_L\tLAB_A\tLAB_B\nEND_DATA_FORMAT'

def read_data(path):
    with open(path, mode='r') as f:
        data = f.read()
        f.close()
    return data

def save_data(header, merged_data):
    with open('3GeneratedFiles/' + TRANSFORMED_FILE_PATH.split('/')[1].split('_')[0] + '_' + TEST_CHART + '_' + OBSERVER + '.txt', mode='w') as f:
        f.write(header + merged_data + 'END_DATA')
        f.close()

def create_header(transformed_data):
    header_up = transformed_data.split('NUMBER_OF_FIELDS')[0]
    header_data_format = 'NUMBER_OF_FIELDS\t' + str(NUMBER_OF_FIELDS) + '\n' + DATA_FORMAT + transformed_data.split('END_DATA_FORMAT')[1].split('BEGIN_DATA')[0] + 'BEGIN_DATA\n'
    return header_up + header_data_format

def merge_data(reference_data, matlab_data):
    df_ref = pd.read_csv(StringIO(reference_data.split('BEGIN_DATA\n')[1].split('END_DATA')[0]), sep="\t", header=None)
    df_mat = pd.read_csv(StringIO(matlab_data), sep="\t", header=None)
    df = pd.concat([df_ref, df_mat], axis=1, sort=False)
    return df.to_csv(header=None, index=None, sep='\t', float_format='%.2f')

def merge_files():
    matlab_data = read_data(MATLAB_FILE_PATH)
    transformed_data = read_data(TRANSFORMED_FILE_PATH)
    reference_data = read_data(REFERENCE_FILE_PATH)

    header = create_header(transformed_data)
    merged_data = merge_data(reference_data, matlab_data)
    save_data(header, merged_data.replace("\r",""))

if __name__ == '__main__':
    merge_files()