import flask
import json

app = flask.Flask(__name__)

@app.route("/")
def hello_world():
  return json.dumps({"message": "Hello, World!"})

# seem to be getting 500s instead of handling 404s...
@app.errorhandler(404)
def page_not_found():
  return json.dumps({"error": "Not found"})

if __name__ == "__main__":
  app.run(None, 8080)
