{join} = require "path"
{spawn, exec} = require "child_process"

process.on "SIGINT", ->
  console.log "SIGINT..."

async = require "async"

timeout = (t, fn) -> setTimeout fn, t

get_config = (lang) ->
  switch lang
    when "node" then ext: ".js", cmd: "node"
    when "ruby" then ext: ".rb", cmd: "ruby"
    when "python" then ext: ".py", cmd: "python"
    when "go" then ext: ".go", cmd: "go", args: ["run"]
    when "clojure" then ext: ".clj", cmd: "lein"

run_implementation = (which, cb) ->

  console.log which

  [lang, impl] = which.split "/"
  config = get_config lang
  
  root = join __dirname, ".."
  target = join root, lang, impl

  mocha = join __dirname, "node_modules", ".bin", "mocha"
  coffee = join __dirname, "node_modules", "coffee-script/register"
  spec = join __dirname, "spec.coffee"

  server_args = ["#{target}/app#{config.ext}"]

  if config.args then server_args = config.args.concat server_args

  server = spawn config.cmd, server_args, (err, stdout, stderr) -> 

  timeout 2000, ->
    runner_args = ["--compilers", "coffee:#{coffee}", "--timeout", 5000, spec]
    runner = spawn "#{mocha}", runner_args, {stdio: "inherit"}

    runner.on "error", (err) ->
      console.log err
      return cb new Error "Tests failed for #{which}"

    runner.on "exit", (code, signal) ->
      server.kill("SIGINT")

      if code isnt 0
        console.log stdout
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




