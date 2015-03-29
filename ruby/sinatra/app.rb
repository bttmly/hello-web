require 'sinatra'
require 'json'

set :port, 8080

get '/' do
  content_type :json
  {message: "Hello, World!"}.to_json
end

not_found do
  status 404
  content_type :json
  {error: "Not found"}.to_json
end
