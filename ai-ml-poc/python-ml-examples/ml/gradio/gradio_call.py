import gradio as gr
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import pad_sequences
import tensorflow as tf

# Load the sentiment analysis model
model = load_model('sentiment_model.h5')

# Tokenizer for text preprocessing
tokenizer = tf.keras.preprocessing.text.Tokenizer()
tokenizer.fit_on_texts(["positive", "negative"])

# Function to make predictions
def predict_sentiment(text):
    sequence = tokenizer.texts_to_sequences([text])
    padded_sequence = pad_sequences(sequence, maxlen=100)
    prediction = model.predict(padded_sequence)[0][0]
    sentiment = 'positive' if prediction > 0.3 else 'negative'
    return sentiment

# Create a Gradio interface
iface = gr.Interface(fn=predict_sentiment, inputs="text", outputs="text")

# Launch the interface
iface.launch()
