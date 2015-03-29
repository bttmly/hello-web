require 'webrick'
require 'json'

server = WEBrick::HTTPServer.new :Port => 8080

server.mount_proc '/' do |req, res|
  res.body = {message: 'Hello, World!'}.to_json
end

trap 'INT' do server.shutdown end
server.start
