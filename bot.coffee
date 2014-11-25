request = require 'request'
qs = require 'querystring'

read_all_input = (cb) ->
  input = ""
  process.stdin.setEncoding "utf8"
  process.stdin.on "readable", ->
    chunk = process.stdin.read()
    if chunk
      input = input + chunk
    else cb ""  if input.length is 0
    return

  process.stdin.on "end", ->
    cb input
    return

  return

say = (msg) ->
  webhook_url = process.env["SLACK_WEBHOOK"]

  request
    method: "POST"
    url: webhook_url,
    json: true,
    body:
      text: msg
      username: process.env["BOT_NAME"] || "chat-bot"

match = (input, regex, cb) ->
  match = input.match(regex)
  return unless match
  cb()

read_all_input (input, error) ->
  if error
    console.error error.message
    process.exit 1

  parsed = qs.parse(input)

  match parsed.text, /hi/i, ->
    say("Hi")
