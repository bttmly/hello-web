# hello-web [![Build Status](https://magnum.travis-ci.com/nickb1080/hello-web.svg?token=7XvHDw5RfvoZwwc5ziV7&branch=master)](https://magnum.travis-ci.com/nickb1080/hello-web)

A collection of tiny 'Hello, World!' servers. For each langauge, there is a "base" example demonstrating how to start an HTTP server using only built-in modules. For some languages there may also be an examples using popular 3rd party web frameworks. These demonstrate how to install dependencies and import packages. Each project runs on a bare Ubuntu Docker container. The `Dockerfile` in each directory contains all steps needed to install the language and package manager on a brand new system.

Each implementation is tested against the same spec, located in `test/spec.coffee`. The spec file and test runner are in CoffeeScript for no particular reason other than it's concise and readable.

## Spec

### Endpoint: `GET /`
Status Code: `200`

Header: `Content-Type: application/json`

Response: `{message: 'Hello, World!'}`


### Endpoint: `GET /{any-other-endpoint}`
Status Code: `404`

Header: `Content-Type: application/json`

Response: `{error: 'Not found'}`


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
