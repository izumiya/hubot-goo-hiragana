module.exports = (robot) ->
  robot.respond /hiragana( (.*))?/i, (msg) ->
    qs = require 'querystring'
    data = qs.stringify
      app_id: process.env.GOO_API_TOKEN,
      sentence: msg.match[2],
      output_type: 'hiragana'
    msg.http("https://labs.goo.ne.jp/api/hiragana")
      .headers
        'Content-Type': 'application/x-www-form-urlencoded'
      .post(data) (err, res, body) ->
        msg.send JSON.parse(body)['converted']
