{expect} = require "chai"
request = require "superagent"

console.log process.env.URL

url = process.env.URL

console.log "runner url #{process.env.URL}"

content_type = (resp) ->
  resp.headers['content-type'] or resp.headers['Content-Type']

describe "GET /", ->
  it "200s", (done) ->
    request.get(url).end (err, resp) ->
      expect(err).to.not.exist
      expect(resp.status).to.equal 200
      expect(content_type resp).to.contain "application/json"
      expect(resp.body).to.deep.equal message: "Hello, World!"
      do done

describe "GET /no-such-route", ->
  it "404s", (done) ->
    request.get("#{url}/no-such-route").end (err, resp) ->
      expect(err).to.exist
      expect(err.status).to.equal 404
      expect(resp.status).to.equal 404
      expect(content_type resp).to.contain "application/json"
      expect(resp.body).to.deep.equal error: "Not found"
      do done
