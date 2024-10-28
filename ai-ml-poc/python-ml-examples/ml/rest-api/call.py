import requests

url = "http://127.0.0.1:5000/predict_sentiment"
data = {"text": "This is a positive text."}

response = requests.post(url, json=data)
result = response.json()

print(result)
