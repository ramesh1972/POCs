from openai import OpenAI
import json

client = OpenAI(api_key="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")

messages = [{"role": "user", "content": "The odd numbers in this group add up to an even number: 4, 8, 9, 15, 12, 2, 1."},
            {"role": "user", "content": "A: The answer is False."},
            {"role": "user", "content": "The odd numbers in this group add up to an even number: 17,  10, 19, 4, 8, 12, 24."},
            {"role": "user", "content": "A: The answer is True."},
            {"role": "user", "content": "The odd numbers in this group add up to an even number: 16,  11, 14, 4, 8, 13, 24."},
            {"role": "user", "content": "A: The answer is True."},
            {"role": "user", "content": "The odd numbers in this group add up to an even number: 17,  9, 10, 12, 13, 4, 2."},
            {"role": "user", "content": "A: The answer is False."},
            {"role": "user", "content": "The odd numbers in this group add up to an even number: 15, 32, 4, 13, 82, 7, 1. "},
            {"role": "user", "content": "A:"}]


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