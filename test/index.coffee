{join} = require "path"
{spawn, exec} = require "child_process"

async = require "async"

run_implementation = (which, cb) ->

  console.log which

  [lang, impl] = which.split "/"
  config =
    switch lang
      when "node" then ext: ".js", cmd: "node"
      when "ruby" then ext: ".rb", cmd: "ruby"
      when "python" then ext: ".py", cmd: "python"
      when "go" then ext: ".go", cmd: "go run"
      when "clojure" then ext: ".clj", cmd: "lein"

  root = join __dirname, ".."
  target = join root, lang, impl

  mocha = join __dirname, "node_modules", ".bin", "mocha"
  coffee = join __dirname, "node_modules", "coffee-script/register"
  spec = join __dirname, "spec.coffee"

  server = exec "#{config.cmd} #{target}/app#{config.ext}", (err, stdout, stderr) ->


  runner = exec "#{mocha} --compilers coffee:#{coffee} --timeout 5000 #{spec}", (err, stdout, stderr) ->
    server.kill()
    if err
      console.log stdout
      error = new Error "Tests failed for #{which}"
      return cb(error)

    console.log stdout
    setTimeout cb, 1000

  runner.on "exit", (code, signal) ->
    console.log "runner exited", code, signal
    server.kill("SIGTERM")

impls = [
  "node/base"
  "node/express"
  "ruby/base"
  "ruby/sinatra"
  "python/base"
  "python/flask"
]

async.eachSeries impls, run_implementation, (err) ->
  throw err if err
  console.log "Passed"



