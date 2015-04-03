# hello-web

A collection of tiny 'Hello, World!' servers. For each langauge, there is a "base" example demonstrating how to start an HTTP server using only built-in modules. For some languages there may also be an examples using popular 3rd party web frameworks. These demonstrate how to install dependencies and import packages. Each project runs on a bare Ubuntu Docker container. The `Dockerfile` in each directory contains all steps needed to install the language and package manager on a brand new system.

### Node
- built-in `http` module
- Express web framework

### Python
- built-in `BaseHTTPServer` class
- Flask web framework

### Ruby
- built-in `WEBRick` module
- Sinatra web framework

### Go
- built-in `http` package

### Still to come...
- Clojure
- Haskell
- ... maybe others
