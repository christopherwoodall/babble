# See:
#  - https://github.com/samrawal/emacs-secondmate/

from . import model

from flask import Flask, request, jsonify


app = Flask(__name__)


@app.route("/", methods=['GET'])
def arguments():
    text = request.args.get("text", "")
    generation = model.autocomplete(text)
    out = {"generation": generation}
    return jsonify(out)


def serve(port: int = 9900):
    app.run(
        host="0.0.0.0",
        port=port,
        # debug=True,
    )

