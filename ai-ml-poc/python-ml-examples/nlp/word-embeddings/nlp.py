import nltk
import gensim
from nltk.corpus import abc

model= gensim.models.Word2Vec(abc.sents())
X= list(model.wv.key_to_index)
data=model.wv.most_similar('science')
print(data)