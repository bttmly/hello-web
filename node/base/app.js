var http = require('http');

var server = http.createServer(function(req, res) {
  res.setHeader("content-type", "application/json");
  if (req.url === "/") {
    return res.end(JSON.stringify({message: "Hello, World!"}));
  }
  res.writeHead(404);
  res.end(JSON.stringify({error: "Not found"}));
});

server.listen(8080);
