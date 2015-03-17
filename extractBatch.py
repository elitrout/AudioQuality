#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os, sys
from scipy.io import wavfile

# audioDir = "./dataset/a_d_test"
# outputDir = "./dataset/a_d_test_features"
audioDir = sys.argv[1]
outputDir = sys.argv[2]

os.mkdir(outputDir)

for dirName, subdirList, fileList in os.walk(audioDir):
    print('Processing directory: %s' % dirName)

    # os.mkdir(outputDir + '/' + dirName[2: ])
    currentDir = outputDir + '/' + dirName.split('/', 3)[-1]
    os.mkdir(currentDir)
    for fname in fileList:
        if fname.endswith('.wav') == True:
            print('\t%s' % fname)

            # inputFile = os.path.join(dirName[2: ], fname)
            inputFile = os.path.join(dirName, fname)
            # outputFile = os.path.join(outputDir, dirName[2: ] + '/' \
            #                           + fname[: -4] + '.yaml')
            outputFile = os.path.join(currentDir, fname[: -4] + '.yaml')

            # convert .Flac to .Wav using ffmpeg
            cmd = 'python ./streaming_extractor/streaming_extractor.py '\
                  + "'" + inputFile + "' '" + outputFile + "'"
            # print cmd
            os.system(cmd)

