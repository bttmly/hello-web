require 'webrick'
require 'json'

server = WEBrick::HTTPServer.new :Port => 8080

server.mount_proc '/' do |req, res|
  res['content-type'] = 'application/json'
  if req.path == '/'
    res.body = {message: 'Hello, World!'}.to_json
  else
    res.body = {error: 'Not found'}.to_json
  end
end

trap 'INT' do server.shutdown end
server.start
