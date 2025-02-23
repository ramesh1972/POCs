# imports
import pandas as pd
import tiktoken
import openai
import json
import signal
import datetime
from openai import OpenAI



API_KEY = "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"

# embedding model parameters	
GPT_MODEL = "gpt-4-turbo"


client = OpenAI(api_key=API_KEY)

# upload files to Open AI
training_file_id = client.files.create(
        file=open("./data/training_data.jsonl","rb"),
        purpose = "fine-tune").id

validation_file_id = client.files.create(
  file=open("./data/validation_data.jsonl", "rb"),
  purpose='fine-tune'
).id

print(f"Training File ID: {training_file_id}")
print(f"Validation File ID: {validation_file_id}")
print("-------------------------")

# create fine tune job in open AI
create_args = {
	"training_file": str(training_file_id),
	"validation_file": str(validation_file_id),
	"model": "gpt-4o-2024-08-06"
}

response = client.fine_tuning.jobs.create(**create_args)
job_id = response.id
status = response.status

print(f'Fine-tunning model with jobID: {job_id}.')
print(f"Training Response: {response}")
print(f"Training Status: {status}")
print("-------------------------")

# stream events from the fine tune job created in Open AI
def signal_handler(sig, frame):
	status = client.fine_tuning.jobs.retrieve(job_id).status
	print(f"Stream interrupted. Job is still {status}.")
	return

print("-------------------------")
print(f'Streaming events for the fine-tuning job: {job_id}')
signal.signal(signal.SIGINT, signal_handler)

events = client.fine_tuning.jobs.list_events( job_id)
try:
	for event in events:
            print(f'{datetime.datetime.fromtimestamp(event["created_at"])} {event["message"]}')

except Exception:
	print("Stream interrupted (client disconnected).")

print("-------------------------")

import time

# print job status
status = client.fine_tuning.jobs.retrieve(job_id).status
if status not in ["succeeded", "failed"]:
	print(f'Job not in terminal status: {status}. Waiting.')
	while status not in ["succeeded", "failed"]:
		time.sleep(2)
		status = client.fine_tuning.jobs.retrieve(job_id).status
		print(f'Status: {status}')
else:
	print(f'Finetune job {job_id} finished with status: {status}')

print("-------------------------")
print('Checking other finetune jobs in the subscription.')
result = client.fine_tuning.jobs.list()
print(f'Found {len(result.data)} finetune jobs.')

# Retrieve the finetuned model
print("-------------------------")

fine_tuned_model = client.fine_tuning.jobs.retrieve(job_id)
print("fine_tuned_model created", fine_tuned_model)
print("-------------------------")

# prompt OpenAI to return fro uploaded files
new_prompt = "Capital of France?"
answer = client.completions.create(
  model=fine_tuned_model,
  prompt=new_prompt
)

print("-------------------------")
print("prompt=" + new_prompt)
print(answer['choices'][0]['text'])

new_prompt = """ Which type of gas is utilized by plants during the process of photosynthesis?"""
answer = client.completions.create(
  model=fine_tuned_model,
  prompt=new_prompt
)

print("-------------------------")
print("prompt=" + new_prompt)
print(answer['choices'][0]['text'])