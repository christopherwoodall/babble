# See:
#  - https://github.com/samrawal/emacs-secondmate/

import urllib

from pathlib import Path

from flask import Flask, request, jsonify

from . import model


app = Flask(
    __name__,
    static_folder=Path(__file__).parent / "www/assets",
    template_folder=Path(__file__).parent / "www",
)


@app.route("/", methods=['GET'])
def arguments():
    text = request.args.get("text", "")
    if not text:
        return Path(Path(__file__).parent / "www/index.html").read_text(encoding='utf-8')

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
