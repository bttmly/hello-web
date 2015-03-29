var express = require("express");

var app = express();

app.get("/", function (req, res) {
  res.send({message: "Hello, World!"});
});

app.use(function (req, res) {
  res.status(404);
  res.send({error: "Not Found"});
});

app.listen(8080);
