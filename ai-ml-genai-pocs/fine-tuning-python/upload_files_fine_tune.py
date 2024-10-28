# imports
import pandas as pd
import tiktoken
import openai
import json
import signal
import datetime


openai.api_key = "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"

# embedding model parameters	
GPT_MODEL = "gpt-3.5-turbo"

# upload files to Open AI
training_file_id = openai.File.create(
  file=open("./data/training_data.jsonl", "r"),
  purpose='fine-tune'
)["id"]

validation_file_id = openai.File.create(
  file=open("./data/validation_data.jsonl", "r"),
  purpose='fine-tune'
)["id"]

print(f"Training File ID: {training_file_id}")
print(f"Validation File ID: {validation_file_id}")
print("-------------------------")

# create fine tune job in open AI
create_args = {
	"training_file": str(training_file_id),
	"validation_file": str(validation_file_id),
	"model": "davinci",
	"n_epochs": 15,
	"batch_size": 3,
	"learning_rate_multiplier": 0.3
}

response = openai.FineTune.create(**create_args)
job_id = response["id"]
status = response["status"]

print(f'Fine-tunning model with jobID: {job_id}.')
print(f"Training Response: {response}")
print(f"Training Status: {status}")
print("-------------------------")

# stream events from the fine tune job created in Open AI
def signal_handler(sig, frame):
	status = openai.FineTune.retrieve(job_id).status
	print(f"Stream interrupted. Job is still {status}.")
	return

print("-------------------------")
print(f'Streaming events for the fine-tuning job: {job_id}')
signal.signal(signal.SIGINT, signal_handler)

events = openai.FineTune.stream_events(job_id)
try:
	for event in events:
            print(f'{datetime.datetime.fromtimestamp(event["created_at"])} {event["message"]}')

except Exception:
	print("Stream interrupted (client disconnected).")

print("-------------------------")

import time

# print job status
status = openai.FineTune.retrieve(id=job_id)["status"]
if status not in ["succeeded", "failed"]:
	print(f'Job not in terminal status: {status}. Waiting.')
	while status not in ["succeeded", "failed"]:
		time.sleep(2)
		status = openai.FineTune.retrieve(id=job_id)["status"]
		print(f'Status: {status}')
else:
	print(f'Finetune job {job_id} finished with status: {status}')

print("-------------------------")
print('Checking other finetune jobs in the subscription.')
result = openai.FineTune.list()
print(f'Found {len(result.data)} finetune jobs.')

# Retrieve the finetuned model
print("-------------------------")

fine_tuned_model = openai.FineTune.retrieve(job_id)["fine_tuned_model"]
print("fine_tuned_model is " + fine_tuned_model)
print("-------------------------")

# prompt OpenAI to return fro uploaded files
new_prompt = "Capital of France?"
answer = openai.Completion.create(
  model=fine_tuned_model,
  prompt=new_prompt
)

print("-------------------------")
print("prompt=" + new_prompt)
print(answer['choices'][0]['text'])

new_prompt = """ Which type of gas is utilized by plants during the process of photosynthesis?"""
answer = openai.Completion.create(
  model=fine_tuned_model,
  prompt=new_prompt
)

print("-------------------------")
print("prompt=" + new_prompt)
print(answer['choices'][0]['text'])