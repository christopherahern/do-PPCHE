node: CP*
coding_query:

1: {
DO: (CP* iDoms IP*) AND (IP* iDomsMod IP*|CONJ* DAG*|DAN*|DO*|DOD*|DOI*|DON*|DOP*) AND (IP* iDomsMod IP*|CONJ* VB|HV)
MOD: (CP* iDoms IP*) AND (IP* iDomsMod IP*|CONJ* BAG*|BE*|BED*|BEI*|BEN*|BEP*|HAG*|HAN*|HV*|HVD*|HVI*|HVN*|HVP*|MD*|MD0*|NEG+MD*)
NOTDO: ELSE
}

2: {
SUBQ: (CP* hasLabel CP-QUE-SUB*)
SBJQ: (CP* hasLabel CP-QUE*) AND (CP* idoms WNP*) AND (CP* iDomsMod IP*|CONJ*|NP-SBJ* \*T\**) AND (WNP* sameIndex \*T\**)
QUE: (CP* hasLabel CP-QUE*)
IMP: (CP* iDomsMod IP*|CONJ* IP-IMP*)
DEC: (CP* iDomsMod IP*|CONJ* IP-MAT*|IP-SUB*)
OTHER: ELSE
}

3: {
NEG: (CP* iDoms IP*) AND (IP* iDomsMod IP*|CONJ* NEG*)
AFF: (CP* iDoms IP*)
}

4 : {
contracted:  NEG: (CP* iDoms IP*) AND (IP* iDomsMod IP*|CONJ* NEG*) AND (NEG* iDoms $n't)
-: ELSE                                                                         
}
