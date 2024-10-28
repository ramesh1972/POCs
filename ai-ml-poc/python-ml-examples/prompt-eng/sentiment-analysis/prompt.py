from openai import OpenAI
import json

client = OpenAI(api_key="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")

messages = [{"role": "system", "content": "you are a sentiment analsyer"},
            {"role": "user", "content": "the product is doing ok"},]

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