from openai import OpenAI
import json

client = OpenAI(api_key="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")

messages = [{"role": "user", "content": "Positive This is awesome!"},
            {"role": "user", "content": "This is bad! Negative"},
            {"role": "user", "content": "Wow that movie was rad!"},
            {"role": "user", "content": "Positive!"},
            {"role": "user", "content": "What an interensting movie!"},]

# prompt technique
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=messages,
) 

for message in messages:
    print(message)

print("---------------------")
print("response");

print(response.choices[0].message.content)