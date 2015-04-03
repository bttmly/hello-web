{join} = require "path"
{spawn, exec} = require "child_process"

async = require "async"

root = join __dirname, ".."
mocha = join __dirname, "node_modules", ".bin", "mocha"
coffee = join __dirname, "node_modules", "coffee-script/register"
spec = join __dirname, "spec.coffee"

timeout = (t, fn) -> setTimeout fn, t

docker_build = (which) ->
  tag = which.replace("/", "-")
  ["docker", ["build", "--tag='#{tag}'", which]]

docker_run = (which) ->
  ["docker", ["run", "-p", "8080:8080", which]]

runner_args = (spec) ->
  [mocha, ["--compilers", "coffee:#{coffee}", "--timeout", 5000, spec], stdio: "inherit"]

kill_all_docker = "docker rm -f $(docker ps -a -q)"

BASE_DELAY = 2000

run_implementation = (which, cb) ->

  console.log "building docker container #{which}..."
  build = spawn docker_build(which)...

  build.on "error", (err) ->
    console.log err
    cb err

  build.on "exit", (code) ->
    unless code is 0
      return cb new Error "Docker build failed for #{which}"

    console.log "starting docker container #{which}..."
    server = spawn docker_run(which)...

    timeout BASE_DELAY, ->

      console.log "starting test runner #{which}..."
      runner = spawn runner_args(spec)...

      runner.on "error", (err) ->
        console.log err
        return cb new Error "Tests failed for #{which}"

      runner.on "exit", (code, signal) ->

        console.log "killing docker processes..."
        exec kill_all_docker, {}, (err) ->
          # if err then cb err

          if code isnt 0
            return cb new Error "Tests failed for #{which}"

          console.log "tests passed successfully #{which}..."
          timeout BASE_DELAY, cb

impls = [
  "node/base"
  "node/express"
  "python/base"
  "python/flask"
  # "go/base"
  # "ruby/base"
  # "ruby/sinatra"
]

exec "which boot2docker", (err, stdout) ->
  if stdout.indexOf "not found" isnt -1
    return exec "boot2docker ip", (err, stdout) ->
      process.env.URL = stdout.split(":").pop().trim() + ":8080"
      do start_running

  process.env.URL = "http://localhost:8080"
  do start_running

start_running = ->
  async.eachSeries impls, run_implementation, (err) ->
    throw err if err
    console.log "Passed"
    do process.exit




