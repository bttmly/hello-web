var express = require("express");

var app = express();

app.get("/", function (req, res) {
  res.json({message: "Hello, World!"});
});

app.use(function (req, res) {
  res.status(404);
  res.json({error: "Not found"});
});

app.listen(8080);
