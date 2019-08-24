import os
import numpy as np
import pickle
import csv
from utils.misc import TextColors, l2norm, read_probs, read_meta

import pandas as pd






def generateFeaturesBinAndMetaFile():
    #vcg_train.bin,vcg_train.meta
    #vcg_test.bin, vcg_test.meta
    featuresFile = '/data1/mlib_data/features/model_feature'
    with open(featuresFile, 'rb') as other_file:
        res = pickle.load(other_file)
        print(type(res))
    res_1=np.asarray(res)
    print(res_1.shape)
    res_1.tofile('/data1/mlib_data/features/vcg_clustering/features/vcg_test.bin')
    featuresClassFile='/data1/mlib_data/features/model_release.txt'
    calssIds=[]
    with open(featuresClassFile) as file:
        csvReader = csv.reader(file, delimiter=',')
        for row in csvReader:
            classId=row[0]


            calssIds.append(classId)

    f= open('/data1/mlib_data/features/vcg_clustering/labels/vcg_test.meta', 'a')
    for classId in calssIds:
        print(classId)
        f.write(classId+'\r\n')


    f.close()






    return None







def splitAndGenerate():
    originalFeatures='/data1/mlib_data/features/model_feature'
    originalMetaFile='/data1/mlib_data/features/model_release.txt'
    splitRatio=0.8
    index2Ids={}
    with open(originalMetaFile) as file:
        csvReader = csv.reader(file, delimiter=',')
        for index,row in enumerate(csvReader):
            classId=row[0]
            index2Ids[str(index)]=classId
        print(index2Ids)
    with open(originalFeatures, 'rb') as other_file:
        res = pickle.load(other_file)
        print(type(res))
    features = np.asarray(res)
    print(features.shape)
    tuples=[]
    for index,feature in enumerate(features):
        tuples.append((str(index),feature))
    np.random.shuffle(tuples)
    split=int(len(features)*splitRatio)
    print('split: %d' % split)
    trainedFeatures=[]
    for tup in tuples[0:(split+1)]:
        trainedFeatures.append(tup[1])


    testFeatures=[]
    for tup in  tuples[split:len(features)]:
        testFeatures.append(tup[1])


    trainedFeaturesBin='/data1/mlib_data/features/vcg_clustering/features/vcg_train.bin'
    testFeaturesBin='/data1/mlib_data/features/vcg_clustering/features/vcg_test.bin'
    trainedMeta='/data1/mlib_data/features/vcg_clustering/labels/vcg_train.meta'
    testMeta='/data1/mlib_data/features/vcg_clustering/labels/vcg_test.meta'

    f = open(trainedMeta, 'a')
    for tup in tuples[0:(split+1)]:
        classId=index2Ids.get(tup[0])
        print(classId)
        f.write(classId + '\r\n')

    f.close()

    f = open(testMeta, 'a')
    for tup in tuples[split:len(features)]:
        classId = index2Ids.get(tup[0])
        print(classId)
        f.write(classId + '\r\n')

    f.close()

    np.asarray(trainedFeatures).tofile(trainedFeaturesBin)
    np.asarray(testFeatures).tofile(testFeaturesBin)























# generateFeaturesBinAndMetaFile()
splitAndGenerate()
