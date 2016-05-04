node: CP*
coding_query:

2: {
MOD: (CP* iDoms IP*) AND (IP* iDomsMod IP*|CONJ* BAG*|BE*|BED*|BEI*|BEN*|BEP*|HAG*|HAN*|HV*|HVD*|HVI*|HVN*|HVP*|MD*|MD0*)
DO: (CP* iDoms IP*) AND (IP* iDomsMod IP*|CONJ* DAG*|DAN*|DO*|DOD*|DOI*|DON*|DOP*)
NOTDO: ELSE
}

3: {
SUBQ: (CP* hasLabel CP-QUE-SUB*)
SBJQ: (CP* hasLabel CP-QUE*) AND (CP* idoms WNP*) AND (CP* iDomsMod IP*|CONJ*|NP-SBJ* \*T\**) AND (WNP* sameIndex \*T\**)
QUE: (CP* hasLabel CP-QUE*)
IMP: (CP* iDomsMod IP*|CONJ* IP-IMP*)
DEC: (CP* iDomsMod IP*|CONJ* IP-MAT*|IP-SUB*)
OTHER: ELSE
}

4: {
NEG: (CP* iDoms IP*) AND (IP* iDomsMod IP*|CONJ* NEG*)
AFF: (CP* iDoms IP*)
}