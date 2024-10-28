from langchain.llms import OpenAI
from langchain.prompts import PromptTemplate
from langchain.chains import LLMChain
import os

# Create an instance of the OpenAI class
def generate_pet_name(animal_type="dog"):
    
    prompt_template = PromptTemplate(
        input_variables=['animal_type'],
        template="I have a {animal_type} as my pet. Suggest me 5 names for it.",
    )

    name_chain = LLMChain(
        llm=OpenAI(api_key="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"),
        prompt=prompt_template,
    )

    response = name_chain({'animal_type': animal_type})
    print(response["text"])


generate_pet_name(animal_type="dog")