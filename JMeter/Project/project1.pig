
-- vim episodeIV_dialogues.txt episodeV_dialogues.txt episodeVI_dialogues.txt
-- Make a textData folder on the HDFS
-- hdfs dfs -mkdir /user/tarun/Projects
--  hdfs dfs -ls /user/tarun/Projects

-- Copy the TXT file, txtFile.txt, into the Projects folder in the HDFS
-- hdfs dfs -put ./episode* /user/tarun/Projects/

-- Already executed manually above section

-- LOAD INPUT FILE FROM HDFS
inpFile4  = LOAD "hdfs:///user/tarun/Projects/episodeIV_dialogues" USING PigStorage('\t') as (name:String, dialogue:String);
inpFile5  = LOAD "hdfs:///user/tarun/Projects/episodeV_dialogues" USING PigStorage('\t') as (name:String, dialogue:String);
inpFile6  = LOAD "hdfs:///user/tarun/Projects/episodeVI_dialogues" USING PigStorage('\t') as (name:String, dialogue:String);

-- Filtering first two lines so as make the dataset common
rankFile4 = RANK inpFile4;
rankFile5 = RANK inpFile5;
rankFile6 = RANK inpFile6;

-- Merging 3 inputs
inputData = UNION rankFile4, rankFile5, rankFile6;

-- Grouping by name
grpByName = GROUP inputData BY name;

-- Count the number of lines by each character
diffNamesCount = FOREACH grpByName GENERATE $0 as name, COUNT($1) as count_of_Lines;
orderedNames = ORDER diffNamesCount BY count_of_Lines DESC;

-- Remove the o/p folder
rmf hdfs:///user/tarun/Projects/Outputs/;

-- Store results in HDFS
STORE orderedNames INTO 'hdfs:///user/tarun/Projects/Outputs/' USING PigStorage('\t');