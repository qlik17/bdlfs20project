# Quellen
# https://github.com/it-gro/ds-lab-data/blob/master/examples/archive.ics.uci.edu/bank/hive/hdp3.1/deploy.sh
# https://github.com/it-gro/ds-lab-data/blob/master/examples/colors/hive/hdp3.1/deploy.sh

cd $(dirname $0)
source ./config.sh

hive_cli -f create.sql

pushd ../../


file=MangaAdaptaitonScore.csv
url='https://storage.googleapis.com/kaggle-data-sets/20277%2F26246%2Fbundle%2Farchive.zip?GoogleAccessId=gcp-kaggle-com@kaggle-161607.iam.gserviceaccount.com&Expires=1591212045&Signature=o0n97hUKWuPEjCy%2Fw3eEIIbRfJ8yAvHblN4qJfgIGoHQs1a%2FCt5DhMEp3vIlMcKL2vXwkaBuIy8ZpMNcrW3fuGrXKn%2B9ieHuUbhQNTntxwanceojldYrOSg2YT5Wb3Q%2FIzMYCb2ZU2ItjhAIQvdYXf9CeGa39TTHsFl852ApKRtiL13fSNaBx%2ByakUABsJR%2BqcELPrJfK8D%2Bn3z0r65vHwghxoXtNKAquEQzhw2RPQRNrV4RJ41cm1uS6JlvhVXacVogCkBOI9wPpp%2F6APdHbNCOzUvawCOUYu0VvQ7K3EWlE0ichhgMefGs6D3WPtobrWOWkntVHRNFeOtfP%2FQIJg%3D%3D'test -e data/$file.zip      || curl $url > data/$file.zip
unzip data/$file.zip

file=Anime.csv
test -e data/$file.zip      || curl $url > data/$file.zip
unzip data/$file.zip

file=profiles.csv
url='https://storage.googleapis.com/kaggle-data-sets/465305%2F874035%2Fcompressed%2Fprofiles.csv.zip?GoogleAccessId=gcp-kaggle-com@kaggle-161607.iam.gserviceaccount.com&Expires=1591264378&Signature=GjT0XTSVHc6sJk3N4kuE3P5vaBJsUqHSeQpMyxs1jsLKniUKc1uXMIca581DtuiVVkzYgMeNni1TchbsTLvypRis4qbRRBE2mncrOtTD0fpo9LZLIoznZuU%2Fu6Wj4Jc0Rppv6Nh%2B5eGz4nZYfYI%2FXPbabne%2F8GPpmm2kelUuuRZ6QZo4yxj5Ia4cgRNDPTy6HmikTttIimGIAWNp%2ByCzt5Jkk9Hoe0zyxVNU37yyjbIQT%2FcgeT8QFWEaAdUmK%2BsgJGjvR0j%2FqKVRTMOHnPd8U2iHZn%2BCtwjs5BbmATcaaxUm7aWxMRuU5U1vys4oS9g6S3Li9CqXL6ZMyr%2BCofHSSQ%3D%3D'
test -e data/$file.zip      || curl $url > data/$file.zip
unzip data/$file.zip

file=animeReviewsOrderByTime.csv
url='https://storage.googleapis.com/kaggle-data-sets/274208%2F582961%2Fcompressed%2FanimeReviewsOrderByTime.csv.zip?GoogleAccessId=gcp-kaggle-com@kaggle-161607.iam.gserviceaccount.com&Expires=1591259862&Signature=QUGHALWCouQxI19m6piJfA8SigEm0EAse%2FlmvAVnMCjnpvxN0YVXPriFRSBLsQfmcw1ScJ8BPqAIxETz2PP6QFtzI1F9wHiZbL2LmyDOdYORrU5Sqla1hbz125oZno1tTxY1OS9EQKRRTg2fJNGwe0dtKLajttv%2BGCTXPuYlEPDhHkGhNrf7YNvlZpBYWpuPTBBMcbnY93b5yGt8H7wTh8iZ8rpcrvRSUghaa%2F0ukyx7MApRtczppMn3Lcch105v7yxq99rGzX5xztZCFeyUls61XsaKmMytVi6dvfD%2B8sHhNzcNkFriehJOVLRL%2FodBQXEVjDAaP%2Bg3Oz90EKFEIg%3D%3D'
test -e data/$file.zip      || curl $url > data/$file.zip
unzip data/$file.zip
head -n 1 data/$file > data/animeReviewsOrderByTimeSmall.csv
tail -n 50000 data/$file >> data/animeReviewsOrderByTimeSmall.csv



tail -n +2 data/MangaAdaptaitonScore.csv | bzip2 | hdfs dfs -put - ${ts_ext}/anime_manga_ext.db/mangalist/mangalist.csv.bz2
tail -n +2 data/Anime.csv | bzip2 | hdfs dfs -put - ${ts_ext}/anime_manga_ext.db/animelist/animelist.csv.bz2
tail -n +2 data/animeReviewsOrderByTimeSmall.csv | bzip2 | hdfs dfs -put - ${ts_ext}/anime_manga_ext.db/reviewlist/reviewlist.csv.bz2
tail -n +2 data/profiles.csv | bzip2 | hdfs dfs -put - ${ts_ext}/anime_manga_ext.db/profilelist/profilelist.csv.bz2


hdfs dfs -put - ${ts_ext}/

hive_cli <<EOSQL
  use anime_manga_ext;
  SELECT COUNT(*) AS cnt from mangalist;
  SELECT COUNT(*) AS cnt from animelist;
  SELECT COUNT(*) AS cnt from reviewlist;
  SELECT COUNT(*) AS cnt from profilelist;
EOSQL

hdfs dfs -ls -R ${ts_ext}/anime_manga_ext.db
