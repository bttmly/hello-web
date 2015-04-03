{join} = require "path"
{spawn, exec} = require "child_process"

async = require "async"

process.env.URL = "http://localhost:8080"

mocha = join __dirname, "node_modules", ".bin", "mocha"
coffee = join __dirname, "node_modules", "coffee-script/register"
spec = join __dirname, "spec.coffee"

runner_args = ->
  [mocha, ["--compilers", "coffee:#{coffee}", "--timeout", 5000, spec], stdio: "inherit"]

server_args = (target, config) ->
  args = ["#{target}/app#{config.ext}"]
  if config.args then args = config.args.concat args
  [config.cmd, args]

timeout = (t, fn) -> setTimeout fn, t

get_config = (lang) ->
  switch lang
    when "node" then ext: ".js", cmd: "node"
    when "ruby" then ext: ".rb", cmd: "ruby"
    when "python" then ext: ".py", cmd: "python"
    when "go" then ext: ".go", cmd: "go", args: ["run"]
    when "clojure" then ext: ".clj", cmd: "lein"

run_implementation = (which, cb) ->

  [lang, impl] = which.split "/"
  config = get_config lang

  target = join __dirname, "..", lang, impl

  console.log "starting #{which} server..."
  server = spawn server_args(target, config)...

  timeout 2000, ->
    console.log "starting #{which} test runner..."
    runner = spawn runner_args()...

    runner.on "error", (err) ->
      console.log err
      return cb new Error "Tests failed for #{which}"

    runner.on "exit", (code, signal) ->
      server.kill "SIGINT"

      if code isnt 0
        return cb new Error "Tests failed for #{which}"

      console.log "#{which} runner exited..."
      timeout 2000, cb

impls = [
  "node/base"
  "node/express"
  "ruby/base"
  "ruby/sinatra"
  "python/base"
  "python/flask"
  "go/base"
]

async.eachSeries impls, run_implementation, (err) ->
  throw err if err
  console.log "Passed"
  do process.exit
