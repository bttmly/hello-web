{join} = require "path"
{spawn, exec} = require "child_process"

async = require "async"

root = join __dirname, ".."
mocha = join __dirname, "node_modules", ".bin", "mocha"
coffee = join __dirname, "node_modules", "coffee-script/register"

timeout = (t, fn) -> setTimeout fn, t

docker_build = (which) ->
  tag = which.replace("/", "-")
  console.log "tag", tag
  ["docker", ["build", "--tag='#{tag}'", which]]

docker_run = (which) ->
  ["docker", ["run", "-d", "-p", "8080:8080", which]]

runner_args = (spec) ->
  [mocha, ["--compilers", "coffee:#{coffee}", "--timeout", 5000, spec], stdio: "inherit"]

kill_all_docker = "docker rm -f $(docker ps -a -q)"

BASE_DELAY = 2000

run_implementation = (which, cb) ->

  if Array.isArray which
    [which, delay] = which
  else
    delay = DELAY

  spec = join __dirname, "spec.coffee"

  console.log "building docker container #{which}..."
  build = spawn docker_build(which)...

  build.on "exit", (status, signal) ->

    console.log "starting docker process #{which}..."
    server = spawn docker_run(which)...

    timeout delay, ->

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
            # console.log stdout
            return cb new Error "Tests failed for #{which}"

          console.log "#{which} runner exited..."
          timeout DELAY, cb

impls = [
  "go/base"
  "node/base"
  "node/express"
  # "ruby/base"
  # "ruby/sinatra"
  "python/base"
  "python/flask"
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




