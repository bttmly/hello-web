import flask
import json

app = flask.Flask(__name__)


@app.route("/")
def hello_world():
    return flask.Response(json.dumps({"message": "Hello, World!"}),
                          mimetype="application/json")


@app.errorhandler(404)
def page_not_found(error):
    return flask.Response(json.dumps({"error": "Not found"}),
                          status=404,
                          mimetype="application/json")

if __name__ == "__main__":
    app.run('0.0.0.0', 8080)
