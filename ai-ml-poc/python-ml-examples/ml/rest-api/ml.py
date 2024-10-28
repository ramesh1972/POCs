import tensorflow as tf
from tensorflow.keras.datasets import imdb
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Embedding, LSTM, Dense
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.callbacks import EarlyStopping
import os.path # to check if model exists or not


# check if model alreadt exists are not
# if exists then load the model and use it
# else create a new model and train it
# and save the model
if os.path.exists('sentiment_model.h5'):
    model = tf.keras.models.load_model('sentiment_model.h5')
else:
    # Load the IMDb dataset
    max_words = 10000
    (x_train, y_train), (x_test, y_test) = imdb.load_data(num_words=max_words)

    # Pad sequences to a maximum length
    maxlen = 100
    x_train = pad_sequences(x_train, maxlen=maxlen)
    x_test = pad_sequences(x_test, maxlen=maxlen)

    # Define the model
    model = Sequential()
    model.add(Embedding(max_words, 50, input_length=maxlen))
    model.add(LSTM(100))
    model.add(Dense(1, activation='sigmoid'))

    # Compile the model
    model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

    # Train the model
    callbacks = [EarlyStopping(monitor='val_loss', patience=3, restore_best_weights=True)]
    model.fit(x_train, y_train, epochs=4, batch_size=64, validation_split=0.2, callbacks=callbacks)

    # Save the model
    model.save('sentiment_model.h5')

# start the webserver where the model will be deployed
from flask import Flask, request, jsonify
import tensorflow as tf
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences

app = Flask(__name__)

# Dummy sentiment analysis model (replace with your actual model)
model = tf.keras.models.load_model('sentiment_model.h5')

# Tokenizer for text preprocessing
tokenizer = Tokenizer()
tokenizer.fit_on_texts(["positive", "negative"])

@app.route('/predict_sentiment', methods=['POST'])
def predict_sentiment():
    try:
        # Get text input from the request
        data = request.get_json(force=True)
        text = data['text']

        # Preprocess the text
        sequence = tokenizer.texts_to_sequences([text])
        padded_sequence = pad_sequences(sequence, maxlen=100)  # Adjust maxlen as needed

        # Make predictions
        prediction = model.predict(padded_sequence)[0][0]

        # Return the result
        result = {'sentiment': 'positive' if prediction > 0.5 else 'negative', "prediction": str(prediction)}
        return jsonify(result)

    except Exception as e:
        return jsonify({'error': str(e)})


if __name__ == '__main__':
    app.run(port=5000, debug=True)
