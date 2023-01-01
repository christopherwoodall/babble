from pathlib import Path


def get(query: str):
    return Path(
        Path(__file__).parent.parent / "data/security_onion_prompt.md"
    ).read_text(encoding="utf-8")[: (1024 - len(query))]


##################################################################
## TODO
# def soc_query_to_dataset():
#   # https://raw.githubusercontent.com/Security-Onion-Solutions/securityonion/master/salt/soc/files/soc/hunt.queries.json
#   ...

# import json

# parsed = ""
# prefix_data = json.loads(Path(Path(__file__).parent / "data/security_onion_prompt.json").read_text(encoding='utf-8'))
# for element in prefix_data:
#   parsed += f"Description: {element['description']}\n"
#   parsed += f"Type: {element['name']}\n"
#   parsed += f"Query: {element['query']}\n"
#   parsed += f"---\n\n"
# Path(Path(__file__).parent / "data/security_onion_prompt.md").write_text(parsed, encoding='utf-8')
# print(parsed)
