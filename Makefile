corpora = $(wildcard corpus/PCEEC/corpus/psd/*.ref) $(wildcard corpus/PPCEME-RELEASE-3/corpus/psd/*/*.psd) $(wildcard corpus/PPCMBE2-RELEASE-1/corpus/psd/*.psd) $(wildcard corpus/PPCME2-RELEASE-4/corpus/psd/*.psd)
CS_COMMAND=java -classpath queries/CS_2.003.04.jar csearch/CorpusSearch

queries/corpus.txt : $(corpora)
	@echo ---Creating a single corpus file---
	@mkdir -p $(@D)
	cat $(corpora) > $@

queries/corpus.txt.out : queries/corpus.txt corpus-tools/add-cp.q
	@echo ---Adding new cp layer to corpus---
	$(CS_COMMAND) $(word 2,$^) $<

queries/corpus.txt.out.out : queries/corpus.txt.out corpus-tools/remove-dup-cp.q
	@echo ---Filtering cp layer---
	$(CS_COMMAND) $(word 2,$^) $<

queries/dummy.out : queries/corpus.txt.out.out corpus-tools/dummy.q
	@echo ---Preparing corpus for duplicate removal---
	$(CS_COMMAND) $(word 2,$^) $<
	mv corpus-tools/dummy.out queries/dummy.out

queries/dummy.psd : queries/dummy.out corpus-tools/RemoveDup.py
	@echo ---Removing duplicate tokens from corpus---
	python $(word 2,$^) $<

queries/do-support.cod : queries/dummy.psd queries/do-support.c
	@echo ---Coding corpus---
	$(CS_COMMAND) $(word 2,$^) $<

queries/do-support.cod.ooo : queries/do-support.cod corpus-tools/only-coding.q
	@echo ---Extracting codes---
	$(CS_COMMAND) $(word 2,$^) $<

data/do-support.txt : queries/do-support.cod.ooo parsedenglish_database/add_metadata.py parsedenglish_database/English_database.txt Makefile
	@echo ---Adding metadata and creating final file---
	@mkdir -p $(@D)
	python $(word 2,$^) $(word 3,$^) $< $@ "do.supp" "clause" "negation"

.PHONY : all
all : data/do-support.txt

.PHONY : clean
clean : 
	@echo --- Removing Intermediate Files ---
	./queries/clean.sh
