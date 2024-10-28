from nltk.sentiment.vader import SentimentIntensityAnalyzer
import pandas as pd

# initialize NLTK sentiment analyzer
analyzer = SentimentIntensityAnalyzer()

# create get_sentiment function
def get_sentiment(text):

    scores = analyzer.polarity_scores(text)

    sentiment = 1 if scores['pos'] > 0 else 0

    return sentiment

# apply get_sentiment function
review = "This is a bad movie"
print("sentiment for '" + review + "' is " + str(get_sentiment(review)))
