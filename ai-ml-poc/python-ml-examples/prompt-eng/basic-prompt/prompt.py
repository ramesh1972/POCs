from openai import OpenAI
import json

client = OpenAI(api_key="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")

messages = [{"role": "user", "content": "Prime Minister of India?"}]

# prompt technique
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=messages,
) 

print(response.choices[0].message.content)