{expect} = require "chai"
request = require "superagent"

URL = "http://localhost:8080"


describe "GET /", ->
  it "200s", (done) ->
    request
      .get URL
      .end (err, resp) ->
        expect(err).to.not.exist

        console.log(resp.status, resp.statusCode)
        expect(resp.status).to.equal 200

        content_type = resp.headers['content-type'] or resp.headers['Content-Type']
        expect(content_type).to.contain "application/json"

        expect(resp.body).to.deep.equal message: "Hello, World!"
        do done

describe "GET /no-such-route", ->
  it "404s", (done) ->
    request
      .get "#{URL}/no-such-route"
      .end (err, resp) ->

        if resp?
          expect(resp.status).to.equal 404

          content_type = resp.headers['content-type'] or resp.headers['Content-Type']
          expect(content_type).to.contain "application/json"

          expect(resp.body).to.deep.equal error: "Not found"

        else
          expect(err.status).to.equal 404

          content_type = err.headers['content-type'] or err.headers['Content-Type']
          expect(content_type).to.contain "application/json"

          expect(err.body).to.deep.equal error: "Not found"

        do done
