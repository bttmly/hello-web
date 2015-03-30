{expect} = require "chai"
request = require "superagent"

URL = "http://localhost:8080"

describe "GET /", ->
  it "200s", (done) ->
    request
      .get URL
      .end (err, resp) ->
        expect(resp.status).to.equal 200
        expect(resp.headers['content-type']).to.equal "application/json"
        expect(resp.body).to.deep.equal message: "Hello, World!"
        do done

describe "GET /no-such-route", ->
  it "404s", (done) ->
    request
      .get "#{URL}/no-such-route"
      .end (err, resp) ->
        expect(resp.status).to.equal 404
        expect(resp.headers['content-type']).to.equal "application/json"
        expect(resp.body).to.deep.equal error: "Not found"
        do done
