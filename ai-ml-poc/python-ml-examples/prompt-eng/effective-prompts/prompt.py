from openai import OpenAI
import json

client = OpenAI(api_key="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")

messages = [{"role": "system", "content": "you are a census officer"},
            {"role": "assistant", "content": "you provide data on demographics"},
            {"role": "user", "content": "provide in json format the population of each state in united states"}]

# prompt technique
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=messages,
) 

print(response.choices[0].message.content)