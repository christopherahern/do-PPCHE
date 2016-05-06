#!/bin/bash
#Steps to run in folder with parsed corpora

# 0) Copy all corpus files into single file in directory
cat corpus/PPCEME-RELEASE-3/corpus/psd/*/*.psd corpus/PPCMBE2-RELEASE-1/corpus/psd/*.psd corpus/PCEEC/corpus/psd/*ref > corpus.txt

# 1) add-cp.q (from corpus-tools repository) on all the corpora
CS_COMMAND="java -classpath ./queries/CS_2.003.04.jar csearch/CorpusSearch"
$CS_COMMAND ./queries/add-cp.q corpus.txt # Adds CPs to every clause in corpus...yeesh
	# Outputs to: corpus.txt.out 

#2) remove-dup-cp.q on output
$CS_COMMAND ./queries/remove-dup-cp.q corpus.txt.out # Removes duplicate CPs add in the previous step...yeesh
	# Outputs to:  corpus.txt.out.out

#3) run RemoveDup.py on the output from remove-dup-cp.q
python RemoveDup.py corpus.txt.out.out
	# Outputs to: corpus.txt.out.psd

#4) Run the external-cp.c query (from corpus-tools repository) on the .psd file output
$CS_COMMAND external-cp.c corpus.txt.out.out
	# Outputs to: external-cp.cod

#5) run the do-support.c query on external-cp.cod
$CS_COMMAND ./queries/do-support.c corpus.txt.out.out
	# Outputs to: ./queries/do-support.cod

#6) Run the only-coding.q query (from corpus-tools repository)
$CS_COMMAND ./queries/only-coding.q ./queries/do-support.cod
	# Outputs to: /queries/do-support.cod.ooo

#7) Run add_metadata.py to create the final file
python3 add_metadata.py
	# Outputs to: do-support.txt

#7) From the corpus-tools directory run fill-in-externals.py with the .cod.ooo file as an argumet
#python fill-in-externals.py do-support.cod.ooo
# cf. http://superuser.com/questions/26834/how-to-join-two-csv-files
# cf. http://bin63.com/how-to-join-two-csv-files-on-unix-linux-and-bsd-systems

#8) Open the .csv file and copy to the end of first row	DO	ClauseType	Neg
# Tack those on in bash.
#sed -i '1 s/.*/&\tDO.SUPP\tCLAUSE\tNEGATION/' do-support.tsv
#sed -i ''  '1 s/.*/&	DO	CLAUSE	NEGATION/' do-support.tsv #OSX

# 9) 
#cut -f1,2,7,8,10,32,33,34 do-support.tsv > do-PPCHE
