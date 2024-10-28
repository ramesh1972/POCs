from nltk.sentiment.vader import SentimentIntensityAnalyzer
import pandas as pd

# initialize NLTK sentiment analyzer
analyzer = SentimentIntensityAnalyzer()

# Load the amazon review dataset
df = pd.read_csv('https://raw.githubusercontent.com/pycaret/pycaret/master/datasets/amazon.csv')

# create get_sentiment function
def get_sentiment(text):

    scores = analyzer.polarity_scores(text)

    sentiment = 1 if scores['pos'] > 0 else 0

    return sentiment

# apply get_sentiment function
# print(get_sentiment('This is a bad movie'))
df['sentiment'] = df['reviewText'].apply(get_sentiment)
print(df)