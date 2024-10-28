from nltk import *
from nltk.corpus import *

def lang_ratio(input):
    lang_ratio={}
    tokens = wordpunct_tokenize(input)
    words = [word.lower() for word in tokens]
    for language in stopwords.fileids():
        stopwords_set = set(stopwords.words(language))
        words_set = set(words)
        common_elements = words_set.intersection(stopwords_set)
        lang_ratio[language] = len(common_elements)
    return lang_ratio 

def detect_language(input):
    ratios = lang_ratio(input)
    lang = max(ratios, key = ratios.get)
    return lang

print("Zu meiner Familie gehören vier Personen: ")
print(detect_language("Zu meiner Familie gehören vier Personen"))
print("---------------------------------------------")
print("To my family belong four persons: ")
print(detect_language("To my family belong four persons"))
print("---------------------------------------------")
print("Je m’appelle Jessica. Je suis une fille: ")
print(detect_language("Je m’appelle Jessica. Je suis une fille: "))
