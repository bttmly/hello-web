{join} = require "path"
{spawn, exec} = require "child_process"

async = require "async"

timeout = (t, fn) -> setTimeout fn, t

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

  server_cmd = "#{config.cmd} #{target}/app#{config.ext}"

  console.log "starting server... #{server_cmd}"

  server = exec server_cmd, (err, stdout, stderr) ->
  # server = spawn config.cmd, ["#{target}/app#{config.ext}"], (err, stdout, stderr) -> 

  timeout 2000, ->
    runner_cmd = "#{mocha} --compilers coffee:#{coffee} --timeout 5000 #{spec}"
    
    console.log "starting runner... #{runner_cmd}"

    runner = exec runner_cmd, (err, stdout, stderr) ->
    # runner = spawn "#{mocha}", ["--compilers", "coffee:#{coffee}", "--timeout", 5000, spec], (err, stdout, stderr) ->

      server.kill()
      if err
        console.log stdout
        return cb new Error "Tests failed for #{which}"

      console.log stdout

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

async.eachSeries impls, (impl, next) -> 
  console.log("running #{impl}")
  run_implementation(impl, next)
, (err) ->
  throw err if err
  console.log "Passed"




