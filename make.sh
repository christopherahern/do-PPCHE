#!/bin/bash
#Steps to run in folder with parsed corpora

# 0) Copy all corpus files into single file in directory
echo "Creating a single corpus file"
cat corpus/PPCEME-RELEASE-3/corpus/psd/*/*.psd corpus/PPCMBE2-RELEASE-1/corpus/psd/*.psd corpus/PCEEC/corpus/psd/*ref > queries/corpus.txt

# 1) add-cp.q (from corpus-tools repository) on all the corpora
echo "Adding new cp layer to corpus"
CS_COMMAND="java -classpath ./queries/CS_2.003.04.jar csearch/CorpusSearch"
$CS_COMMAND ./queries/add-cp.q ./queries/corpus.txt # Adds CPs to every clause in corpus...yeesh
	# Outputs to: corpus.txt.out 

#2) remove-dup-cp.q on output
echo "Filtering cp layer"
$CS_COMMAND ./queries/remove-dup-cp.q ./queries/corpus.txt.out # Removes duplicate CPs add in the previous step...yeesh
	# Outputs to:  corpus.txt.out.out

#3) run dummy.q to prepare corpus for RemoveDup.py
echo "Preparing corpus for duplicate removal"
$CS_COMMAND ./queries/dummy.q ./queries/corpus.txt.out.out
	# Outputs to: ./queries/dummy.out

#4) run RemoveDup.py on the output from dummy.q (Removes tokens with identical text; deals with corpus overlap issues)
echo "Removing duplicate tokens from corpus"
python ./queries/RemoveDup.py ./queries/dummy.out
	# Outputs to: dummy.psd

#5) run the do-support.c query on dummy.psd
echo "Coding corpus"
$CS_COMMAND ./queries/do-support.c ./queries/dummy.psd
	# Outputs to: ./queries/do-support.cod

#6) Run the only-coding.q query (from corpus-tools repository)
echo "Extracting codes"
$CS_COMMAND ./queries/only-coding.q ./queries/do-support.cod
	# Outputs to: /queries/do-support.cod.ooo

# To this point is: 10 min 
#7) Run add_metadata.py to create the final tab-separated file
echo "Adding metadata and creating final file"
mkdir data
python ./queries/add_metadata.py
	# Outputs to: do-support.txt

# 8) Clean up intermediate files that duplicate the corpus
#echo "Cleaning up intermediate duplicate files"
./queries/clean.sh
