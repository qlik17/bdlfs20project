-- Quellen
-- https://github.com/it-gro/ds-lab-data/blob/master/examples/colors/hive/hdp3.1/create.sql
-- https://github.com/it-gro/ds-lab-data/blob/master/examples/archive.ics.uci.edu/bank/hive/hdp3.1/create.sql

CREATE DATABASE IF NOT EXISTS anime_manga_ext;
use anime_manga_ext;


DROP TABLE mangalist;

CREATE EXTERNAL TABLE mangalist (
     mangaID              INT      COMMENT ''
   , mangaTitle              STRING   COMMENT ''
   , mangaRating              DOUBLE   COMMENT ''
   , adaptationTitle              STRING   COMMENT ''
   , adaptationRating              DOUBLE   COMMENT ''
 )
  COMMENT 'This dataset is public available for research.'
  ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ','
  STORED AS TEXTFILE
;


DROP TABLE animelist;

CREATE EXTERNAL TABLE animelist (
     animeID          INT      COMMENT ''
   , name             STRING   COMMENT ''
   , title_english              STRING   COMMENT ''
   , title_japanese              STRING   COMMENT ''
   , title_synonyms              STRING   COMMENT ''
   , type              STRING   COMMENT ''
   , source              STRING   COMMENT ''
   , producers              STRING   COMMENT ''
   , genre              STRING   COMMENT ''
   , studio              STRING   COMMENT ''
   , episodes              INT   COMMENT ''
   , status              STRING   COMMENT ''
   , airing              BOOLEAN   COMMENT ''
   , aired              STRING   COMMENT ''
   , duration              STRING   COMMENT ''
   , rating              STRING   COMMENT ''
   , score              DOUBLE   COMMENT ''
   , scored_by              INT   COMMENT ''
   , rank              INT   COMMENT 'Rang'
   , popularity              INT   COMMENT 'Beliebtheit'
   , members              INT   COMMENT ''
   , favorites              INT   COMMENT ''
   , synopsis              STRING   COMMENT ''
   , background              STRING   COMMENT ''
   , premiered              STRING   COMMENT ''
   , broadcast              STRING   COMMENT ''
   , related              STRING   COMMENT ''
   
 )
  COMMENT 'This dataset is public available for research.'
  ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ','
  STORED AS TEXTFILE
;


DROP TABLE profilelist;

CREATE EXTERNAL TABLE profilelist (
     profile              STRING   COMMENT 'profilename'
   , gender               STRING   COMMENT 'geschlecht'
   , birthday             STRING   COMMENT 'Geburtstag - nicht formatiert'
   , favorites_anime      STRING   COMMENT ''
   , link                 STRING   COMMENT ''
   
 )
  COMMENT 'This dataset is public available for research.'
  ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ','
  STORED AS TEXTFILE
;



DROP TABLE reviewlist;

CREATE EXTERNAL TABLE reviewlist (
     id              	INT      	COMMENT 'ID'
   , workId          	INT   		COMMENT 'AnimeID MAL'
   , reviewId        	INT			COMMENT 'ReviewID MAL'
   , workName       	STRING   	COMMENT 'AnimeTitle MAL'
   , postTime        	TIMESTAMP  	COMMENT 'postTime'
   , episodesSeen    	STRING   	COMMENT 'episodesSeen'
   , author          	STRING   	COMMENT 'profilename'
   , peopleFoundUseful  INT   		COMMENT 'peopleFoundReviewUseful'
   , overallRating      INT   		COMMENT 'overallRating'
   , storyRating        INT   		COMMENT 'storyRating'
   , animationRating    INT   		COMMENT 'animationRating'
   , soundRating        INT   		COMMENT 'soundRating'
   , characterRating    INT   		COMMENT 'characterRating'
   , enjoymentRating    INT   		COMMENT 'enjoymentRating'
   , review             STRING   COMMENT ''   
 )
  COMMENT 'This dataset is public available for research.'
  ROW FORMAT DELIMITED
  FIELDS TERMINATED BY ','
  STORED AS TEXTFILE
;
