# Description

This repository contains the source code to generate do-support data from 
the [Penn Parsed Corpora of Middle English](https://www.ling.upenn.edu/hist-corpora/)
and the [York-Helsinki Parsed Corpus of Early English Correspondence](http://www-users.york.ac.uk/~lang22/PCEEC-manual/index.htm).

The queries and the code were constructed by [Hezekiah Akiva Bacovcin](http://www.hakivabacovcin.com/) and 
[Christopher Ahern](http://christopherahern.github.io/).  


# Instructions

## Data

Starting in the 15th century we see a change in how tense is expressed in English sentences.
In particular, we see an increase in the use of periphrastic *do* as the element that carries
or *supports* the tense information in the sentence.

For example:

> Asked you a question?

becomes: 

> Did you ask a question?

The change towards *do*-support  progresses over several centuries at different rates in different contexts.
The data set generated by this repository covers the period from roughly 1400-1900.
 

## Code

To run the code either download the files as a [ZIP](https://github.com/christopherahern/do-PPCHE/archive/master.zip),
 or clone the repository:

    git clone https://github.com/christopherahern/do-PPCHE.git

Change directories to the cloned repository. If all of the corpora required (PPCME2, PPCEME, PPCMBE2, PCEEC) are all
in the same directory, then create a symbolic link to that directory:

    ln -s <directory containing all of the corpora> corpus

If the corpora are located in various directory, then create a corpus directory, change to that directory and
create symbolic links to the root directories of each of the individual corpora:

    mkdir corpus
    cd corpus
    ln -s <location of corpus>
    ...

Then pull in [information](https://github.com/bacovcin/parsedenglish_database/tree/9a049bd27df1d89acd6ddba3eb58169d964c1f14)
 about the documents in the corpus:

    git submodule update --init

Once you've structured the repository, run the make script, which outputs the data to `data/do-support.txxt`:

    ./make.sh


As a point of reference, `make.sh` takes about 13 minutes to run on a desktop with other applications running:

    time ./make.sh


## Output

In addition to the information compiled in [this repository](https://github.com/bacovcin/parsedenglish_database/blob/9a049bd27df1d89acd6ddba3eb58169d964c1f14/English_database.txt).
The data will be output to `data/do-support.txt` with the following additional columns:
do.supp	clause	negation
* do.supp : whether or not the token exhibits do-support
* clause : the kind of clause (declarative, question, imperative)
* negation : whether the sentence contains sentential negation or not

Note that these are all defined by the queries in `coding.c`.


# Citation

If you use this repository to generate data, please cite it. More importantly, if you use data generated
from the parsed corpus please cite [the corpora](https://www.ling.upenn.edu/hist-corpora/citing-corpora.html):

> Kroch, Anthony, and Ann Taylor. 2000. The Penn-Helsinki Parsed Corpus of Middle English (PPCME2). Department of Linguistics, University of Pennsylvania. CD-ROM, second edition, release 4. 

> Kroch, Anthony, Beatrice Santorini, and Lauren Delfs. 2004. The Penn-Helsinki Parsed Corpus of Early Modern English (PPCEME). Department of Linguistics, University of Pennsylvania. CD-ROM, first edition, release 3. 

> Kroch, Anthony, Beatrice Santorini, and Ariel Diertani. 2016. The Penn Parsed Corpus of Modern British English (PPCMBE2). Department of Linguistics, University of Pennsylvania. CD-ROM, second edition, release 1.

> Taylor, Ann, Arja Nurmi, Anthony Warner, Susan Pintzuk, and Terttu Nevalainen. 2006. The York-Helsinki Parsed Corpus of Early English Correspondence (PCEEC). Department of Linguistics, University of York. Oxford Text Archive, first edition.

It takes a lot of time and effort to build and annotate historical corpora well, so it's important to acknowledge that hard work. 

# Comments

If you have comments or questions about anything, feel free to email hbacovci@gmail.com 
or christopher.ahern@gmail.com, or [create an issue](https://github.com/christopherahern/do-PPCHE/issues)
