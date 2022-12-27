# See:
#  - https://github.com/kingoflolz/mesh-transformer-jax/

import torch

from transformers import pipeline
from transformers import AutoTokenizer, AutoModelForCausalLM

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
    task='text-generation',
    # model=model_name,
    model=model,
    tokenizer=tokenizer,
    device=device,
)


def autocomplete(plaintext, to_prime=True, temperature=0.8, max_length=300):
    # prompt = prime + plaintext if to_prime else plaintext
    prompt = plaintext
    generation = generator(prompt, do_sample=True, min_length=50, max_new_tokens=128)
    return generation


# TODO: Prompt pipeline with some context; e.g. prepending input to provide more context.
# Anecdotally, this helps, but may not need for larger models.
# prime = '''
# def is_palendrome(s):
#     """Check whether a string is a palindrome"""
#     for i in range(len(s) - 1, -1, -1):
#         if s[i + 1] == s[i]:
#             return False
#     return True
# ###
# def is_even(i):
#     """Check whether an integer is even"""
#     return i % 2
# ###
# def square_root(i):
#     """Return the square root of an integer"""
#     return math.sqrt(i)
# ###
# '''

