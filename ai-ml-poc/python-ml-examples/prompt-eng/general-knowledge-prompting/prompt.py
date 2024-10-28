from openai import OpenAI
import json

client = OpenAI(api_key="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")

messages = [{"role": "user", "content": "Question: Part of golf is trying to get a higher point total than others. Yes or No"},
            {"role": "user", "content": "Knowledge: The objective of golf is to play a set of holes in the least number of strokes. A round of golf typically consists of 18 holes. Each hole is played once in the round on a standard golf course. Each stroke is counted as one point, and the total number of strokes is used to determine the winner of the game."},
            {"role": "user", "content": "Explain and Answer:"}]

# prompt technique
response = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=messages,
) 

for message in messages:
    print(message)

print ("---------------------")
print ("response");
print(response.choices[0].message.content)