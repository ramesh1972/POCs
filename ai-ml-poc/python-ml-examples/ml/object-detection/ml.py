import tensorflow as tf
import tensorflow_hub as hub
import cv2
import numpy as np

# Load the MobileNetV2 model
model_url = "https://tfhub.dev/google/tf2-preview/mobilenet_v2/classification/4"
model = hub.load(model_url)

# Load an example image containing a flower
image_path = "tulip.jpg"
image = cv2.imread(image_path)
image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

# Resize the image to the input size expected by MobileNetV2
input_size = (224, 224)
input_image = cv2.resize(image_rgb, input_size)

# Normalize the pixel values to be between 0 and 1
input_image = input_image / 255.0

# Add a batch dimension and convert to a tensor
input_tensor = tf.convert_to_tensor(input_image[np.newaxis, ...], dtype=tf.float32)

# Make predictions
predictions = model(input_tensor)

# Get the top prediction
top_prediction = tf.argmax(predictions, axis=-1)[0].numpy()

# Get the class label
class_label = "flower" if top_prediction > .5 else "not a flower"

# Display the result
cv2.putText(image, class_label, (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
cv2.imshow("Flower Classification", cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
cv2.waitKey(0)
cv2.destroyAllWindows()
