# Command Line workflow

# 1. Feature extraction
# usage: python extractBatch.py inputFolder outputFolder
python extractBatch.py ./dataset/a_d_train ./dataset/a_d_train_features
python extractBatch.py ./dataset/a_d_test ./dataset/a_d_test_features

# 2. .YAML to .ARFF conversion
# usage: python essentiaToWeka.py --inputFolder inputFolder --label classOfInstances --clusters allClasses
# Note: all .yaml files in inputFolder will be converted into 1 .arff file.
python essentiaToWeka.py --inputFolder ./dataset/a_d_train_features/cd --label cd --clusters cd,vinyl
python essentiaToWeka.py --inputFolder ./dataset/a_d_train_features/vinyl --label vinyl --clusters cd,vinyl
python essentiaToWeka.py --inputFolder ./dataset/a_d_test_features/cd --label cd --clusters cd,vinyl
python essentiaToWeka.py --inputFolder ./dataset/a_d_test_features/vinyl --label vinyl --clusters cd,vinyl

# 3. Append .ARFF files using Weka. Can be manually done.
java weka.core.Instances append ./dataset/a_d_test_features/cd.arff ./dataset/a_d_test_features/vinyl.arff > ./dataset/a_d_test_features/test.arff
java weka.core.Instances append ./dataset/a_d_train_features/cd.arff ./dataset/a_d_train_features/vinyl.arff > ./dataset/a_d_train_features/train.arff
