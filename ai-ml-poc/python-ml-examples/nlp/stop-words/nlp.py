from nltk.corpus import stopwords
stop_words = stopwords.words('english')
print(len(stop_words), "stopwords:", stop_words)

text = "Computers don't speak English. So, we've to learn C, C++, Java, Python and the like! Yay!"

from nltk.tokenize import word_tokenize
words = word_tokenize(text)

print("---------------------------")
print(len(words), "in original text:", words)

print("---------------------------")
words = [word for word in words if word not in stop_words]
print(len(words), "without stopwords:", words)