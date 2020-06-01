# Quellen
# https://github.com/it-gro/ds-lab-data/blob/master/examples/archive.ics.uci.edu/bank/hive/hdp3.1/deploy.sh
# https://github.com/it-gro/ds-lab-data/blob/master/examples/colors/hive/hdp3.1/deploy.sh

cd $(dirname $0)
source ./config.sh

hive_cli -f create.sql

tail -n +2 /tmp/project/prod/MangaAdaptaitonScore.csv | bzip2 | hdfs dfs -put - ${ts_ext}/anime_manga_ext.db/mangalist/mangalist.csv.bz2
tail -n +2 /tmp/project/prod/Anime.csv | bzip2 | hdfs dfs -put - ${ts_ext}/anime_manga_ext.db/animelist/animelist.csv.bz2
tail -n +2 /tmp/project/prod/animeReviewsOrderByTimeSmall.csv | bzip2 | hdfs dfs -put - ${ts_ext}/anime_manga_ext.db/reviewlist/reviewlist.csv.bz2
tail -n +2 /tmp/project/prod/profiles.csv | bzip2 | hdfs dfs -put - ${ts_ext}/anime_manga_ext.db/profilelist/profilelist.csv.bz2


hdfs dfs -put - ${ts_ext}/

hive_cli <<EOSQL
  use anime_manga_ext;
  SELECT COUNT(*) AS cnt from mangalist;
  SELECT COUNT(*) AS cnt from animelist;
  SELECT COUNT(*) AS cnt from reviewlist;
  SELECT COUNT(*) AS cnt from profilelist;
EOSQL

hdfs dfs -ls -R ${ts_ext}/anime_manga_ext.db