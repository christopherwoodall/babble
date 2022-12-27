# See:
#  - https://github.com/samrawal/emacs-secondmate/

import urllib

from flask import Flask, request, jsonify

from . import model


app = Flask(__name__)


@app.route("/", methods=['GET'])
def arguments():
    text = request.args.get("text", "")
    text = urllib.parse.unquote(text)

    generation = model.autocomplete(text)
    out = {"generation": generation}
    return jsonify(out)


def serve(port: int = 9900):
    app.run(
        host="0.0.0.0",
        port=port,
        # debug=True,
    )

