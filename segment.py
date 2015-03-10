#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Get 30-second excerpt in the middle of the song. Flac to Wav conversion using ffmpeg.
Usage:
    python segment.py

"""

import os
from scipy.io import wavfile

audioDir = "./dataset"
outputDir = "./output"
os.mkdir(outputDir)

segLen = 30
segLenH = segLen / 2

for dirName, subdirList, fileList in os.walk(audioDir):
    print('Processing directory: %s' % dirName)

    os.mkdir(outputDir + '/' + dirName[2: ])
    i = 0
    for fname in fileList:
        # get only first 5 songs
        if i >= 5:
            break

        if fname[-5: ] == '.flac':
            inputFlac = os.path.join(dirName[2: ], fname)
            outputWav = os.path.join(outputDir, dirName[2: ] + '/' + fname[: -5] + '.wav')

            # convert .Flac to .Wav using ffmpeg
            os.system('ffmpeg -i "' + inputFlac + '" "' + outputWav + '"')

            # segment file
            fs, x = wavfile.read(outputWav)
            seg = x[len(x) / 2 - segLenH * fs : len(x) / 2 + segLenH * fs]
            # this would overwrite file with the segment
            wavfile.write(outputWav, fs, seg)

            i += 1
            print('\t%s' % fname)
