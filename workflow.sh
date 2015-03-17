python extractBatch.py ./dataset/a_d_train ./dataset/a_d_train_features
python extractBatch.py ./dataset/a_d_test ./dataset/a_d_test_features

python essentiaToWeka.py --inputFolder ./dataset/a_d_train_features/cd --label cd --clusters cd,vinyl
python essentiaToWeka.py --inputFolder ./dataset/a_d_train_features/vinyl --label vinyl --clusters cd,vinyl
python essentiaToWeka.py --inputFolder ./dataset/a_d_test_features/cd --label cd --clusters cd,vinyl
python essentiaToWeka.py --inputFolder ./dataset/a_d_test_features/vinyl --label vinyl --clusters cd,vinyl

java weka.core.Instances append ./dataset/a_d_test_features/cd.arff ./dataset/a_d_test_features/vinyl.arff > ./dataset/a_d_test_features/test.arff
java weka.core.Instances append ./dataset/a_d_train_features/cd.arff ./dataset/a_d_train_features/vinyl.arff > ./dataset/a_d_train_features/train.arff
