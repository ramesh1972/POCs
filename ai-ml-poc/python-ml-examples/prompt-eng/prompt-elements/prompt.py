from openai import OpenAI
import json


client = OpenAI(api_key="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")

messages = [{"role": "system", "content": "you are a geologist"},
            {"role": "assistant", "content": "you provide data on geography"},
            {"role": "user", "content": "provide in json format the area of each state in India"}]

# prompt technique
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=messages,
) 

print(response.choices[0].message.content)