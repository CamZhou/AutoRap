import random
SENTENCE_ENDINGS = '.?!'


debug = False

def readFile():
    '''
    Reads the given file and returns a list of words in that file. 
    '''
    words = list()
    while True:
        try:
            filename = raw_input('Please enter the file name: ')
            words = open(filename, 'r').readlines()
            break
        except IOError:
            print "Sorry, the input file is not found. Please type the file name again."

    words = [wrd[:-1] for wrd in words[:-1]]+[words[-1]]
    words = [wrd.split(' ') for wrd in words]
    wordsList = list()
    for i in range(len(words)):
        for j in range(len(words[i])):
            wordsList.append(words[i][j])

    return wordsList



def endsSentence(word):
    '''
    Returns true if the "word" ends a sentence (i.e., the last character of the
    word is a punctuation mark that ends a sentence).
    '''
    for e in SENTENCE_ENDINGS:
        if e in word:
            return True
    return False

def sentences(wordsList):
    '''
    Takes a list of words wordsList and returns a list of sentences, where each sentence
    is a list of words.
    '''
    sentList = list()
    i = 0
    while i<len(wordsList):
        newlist = list()
        j = i
        while j<len(wordsList) and endsSentence(wordsList[j])==False:
            newlist.append(wordsList[j])
            j+=1
        if j<len(wordsList):
                
            newlist.append(wordsList[j])
        sentList.append(newlist)
        i = j+1
    return sentList

    

def starters(sentList, k):
    ''' 
    Takes a list of words and a parameter k and returns a tuple with the first k words of a random sentence in the words
    list. 
    '''

    sent = []
    tup = ()
    while len(sent)<k:
        sent = random.choice(sentList)
    tup += (sent[0],)
    for p in range(1,k):
        tup+=(sent[p],)

    return tup

    

def learn(sentList, k):
    '''
    Takes the list of strings and a parameter k >= 1 as input and
    returns a dictionary in which the keys are all the k-tuples
    of consecutive words in the dictionary and the value associated
    with a key is the list of all words - with repetitions - that 
    appear immediately after that k-tuple. 
    '''
    worddict = {}


    for i in range(len(sentList)):
        for j in range(len(sentList[i])-k):
            tup = ()
            tup += (sentList[i][j],)
            for p in range(1,k):
                tup+=(sentList[i][j+p],)

            val = [sentList[i][j+k]]
            if tup not in worddict:
                worddict[tup]=val
            else:
                worddict[tup]+=val
    return worddict

def generate(filename,length,k):
    '''
    Takes a filename, the desired number of output
    sentences, and the order of the Markov process. Generates random 
    text of the specified number of sentences and prints them to 
    the screen.
    '''

    sentList = sentences(filename)
    
    for i in range(length):
        startertup = starters(sentList,k)
        for i in range(len(startertup)):
            print startertup[i],
        mdict = learn(sentList,k)

        nextwrd = generateNext(mdict,startertup)
        print nextwrd,
        startertup = startertup[1:]+(nextwrd,)

        while endsSentence(nextwrd)==False and startertup in mdict:
            nextwrd = generateNext(mdict, startertup)
            print nextwrd,
            startertup = startertup[1:]+(nextwrd,)


def generateNext(markovD, startertup):
    '''
    Takes a Markov dictionary,  and the starter tuple. Generates a random 
    word followed by the texts in the starter tuple.
    '''
    possWrd = markovD[startertup]
    return random.choice(possWrd)

def main():
    '''
    Get input from the user, learn from the training data, and print randomly
    generated text.
    '''


    filename = readFile()
    numOfSent = 0
    numOfOrd = 0
    while True:
        try:
            numOfSent = int(raw_input('How many sentences do you want? '))
            if numOfSent < 1:
                raise ValueError()
            break
        except ValueError:
            print('Please put in a valid number.')
    while True:
        try:
            numOfOrd = int(raw_input('What Markov order of the process do you want? '))
            if numOfOrd < 1:
                raise ValueError()
            break
        except ValueError:
            print('Please put in a valid number.')


    generate(filename,numOfSent,numOfOrd)



    
    

if __name__ == '__main__':
    main()

