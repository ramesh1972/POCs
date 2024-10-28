import nltk
#from nltk.book import *

text12 = 'This is the first sentence. A gallon of milk in the U.S. costs $2.99. Is this the third sentence? Yes, it is!'
sentences = nltk.sent_tokenize(text12)
print(sentences)