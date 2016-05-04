#!/bin/bash
#Steps to run in folder with parsed corpora

# 0) Copy all corpus files into single file in directory
cat data/PPCEME-RELEASE-3/corpus/psd/*/*.psd data/PPCMBE2-RELEASE-1/corpus/psd/*.psd data/PCEEC/corpus/psd/*ref > corpus.txt

# 1) add-cp.q (from corpus-tools repository) on all the corpora
CS_COMMAND="java -classpath ./CS_2.003.04.jar csearch/CorpusSearch"
$CS_COMMAND

2) remove-dup-cp.q on output
3) run RemoveDup.py on the output from remove-dup-cp.q
4) Run the external-cp.c query (from corpus-tools repository) on the .psd file output
5) run the do-support.c query on external-cp.cod
6) Run the only-coding.q query (from corpus-tools repository)
7) From the corpus-tools directory run fill-in-externals.py with the .cod.ooo file as an argumet
8) Open the .csv file and copy to the end of first row	DO	ClauseType	Neg
