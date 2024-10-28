import tensorflow as tf
from tensorflow.keras.datasets import imdb
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.sequence import pad_sequences
import numpy as np
import os.path # to check if model exists or not

if os.path.exists('sentiment_model.h5'):
    model = load_model('sentiment_model.h5')    
else:
    # Load the IMDb dataset
    max_words = 10000
    (x_train, y_train), (x_test, y_test) = imdb.load_data(num_words=max_words)

    # Pad sequences to a maximum length
    maxlen = 100
    x_train = pad_sequences(x_train, maxlen=maxlen)
    x_test = pad_sequences(x_test, maxlen=maxlen)

    # Define the model
    model = tf.keras.Sequential([
        tf.keras.layers.Embedding(max_words, 50, input_length=maxlen),
        tf.keras.layers.LSTM(100),
        tf.keras.layers.Dense(1, activation='sigmoid')
    ])

    # Compile the model
    model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])

    # Train the model
    model.fit(x_train, y_train, epochs=2, batch_size=64, validation_split=0.2)

    # Evaluate on the test set
    _, test_accuracy = model.evaluate(x_test, y_test)
    print(f"Test Accuracy: {test_accuracy}")

    # Save the model
    model.save('sentiment_model.h5')