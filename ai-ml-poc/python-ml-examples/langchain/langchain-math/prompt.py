from langchain.llms import OpenAI
from langchain.prompts import PromptTemplate
from langchain.chains import LLMMathChain


llm = OpenAI(temperature=0, api_key="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")
llm_math = LLMMathChain.from_llm(llm, verbose=True)

llm_math.run("What is 8 raised to the 2 power?")


llm_math.run("What is 13 raised to the .3432 power?")