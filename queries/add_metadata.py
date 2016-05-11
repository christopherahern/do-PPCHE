# Function that returns an integer if the string is an integer and
# -1000 otherwise


def tryint(x):
    try:
        return(int(x))
    except:
        return(-1000)


# Generates a python database and adds correct metadata to file

dbfile = open('./parsedenglish_database/English_database.txt').readlines()

names = '\t'.join(dbfile[0].rstrip().split(':'))

db = {}
# Database is a dictionary of dicitonaries
# Key of first dictionary: file id
# Key of second dictionary: tuple of start token num and end token num
# For single text files the token ids = x
for line in dbfile[1:]:
    s = line.rstrip().split(':')
    print(s[0])
    try:
        db[s[0]][(s[1], s[2])] = '\t'.join(s)
    except:
        db[s[0]] = {}
        db[s[0]][(s[1], s[2])] = '\t'.join(s)

# Add the non-metadata column labels
#names += open('./database/CodingNames.txt').readline()

# Open the final file
outfile = open('do-support.txt', 'w')
outfile.write(names)

# Load the coding output
coded_file = open('./queries/do-support.cod.ooo').readlines()

# Walk through output and append appropriate metadata
keyerrors = []
i = 0
filelen = len(coded_file)
for line in coded_file:
    i += 1
    #print (str(i) + ' out of ' + str(filelen))
    codes = '\t'.join(line.split('@')[0].split(':')) + '\n'
    token = line.split('@')[1].split('.')[-1].rstrip()
    filename = line.split('@')[1].split(',')[0].lower()
    try:
        for text in db[filename].keys():
            # Check if file is:
            # Single text (i.e. startid == 'x'
            # or if the tokenid is between the text's start and end ids
            if ((text[0] == 'x') or
               ((tryint(token) >= tryint(text[0]) and
                 (tryint(token) <= tryint(text[1]))))):
                outfile.write(db[filename][text] +
                              '\t' +
                              token +
                              '\t' +
                              codes)
    except:
        if filename not in keyerrors:
            keyerrors.append(filename)

outfile = open('missing_keys.txt', 'w')
for filename in keyerrors:
    outfile.write(filename + '\n')
