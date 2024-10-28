from openai import OpenAI
import json

client = OpenAI(api_key="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")

response = client.models.list()

print(response.data)

for model in response.data:
    print(model.id)
    print(model.owned_by)
    print("--------------")