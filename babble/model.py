# See:
#  - https://github.com/kingoflolz/mesh-transformer-jax/

from pathlib import Path

import torch

from transformers import pipeline
from transformers import AutoTokenizer, AutoModelForCausalLM


from .pipelines import prompt as prompt_pipeline


############
# Devices
#   - device =  1   utilize GPU cuda:1
#   - device =  0   utilize GPU cuda:0
#   - device = -1   default value, utilize CPU
device = 0 if torch.cuda.is_available() else -1
model_name = "gpt2"

tokenizer = AutoTokenizer.from_pretrained(model_name)
model = AutoModelForCausalLM.from_pretrained(model_name)
generator = pipeline(
    task="text-generation",
    model=model,
    tokenizer=tokenizer,
    device=device,
)


def autocomplete(
    query: str, to_prime: bool = True, temperature: float = 0.8, max_length: int = 300
):
    # TODO: Prompt pipeline with some context; e.g. prepending input to provide more context.
    # Anecdotally, this helps, but may not need for larger models.
    prefix = prompt_pipeline.get(query)
    prompt = prefix + query if to_prime else query
    generation = generator(prompt, do_sample=True, min_length=50, max_new_tokens=128)
    return generation
