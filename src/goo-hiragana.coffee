# Description:
#   漢字を読みます！
#
# Configuration:
#   HUBOT_GOO_API_TOKEN - gooラボAPIのアプリケーションID
#
# Commands:
#   hubot これ読んで <query> - <query>を読み上げます
#
# Author:
#   izumiya
module.exports = (robot) ->
  robot.respond /これ読んで( (.*))?/i, (msg) ->
    qs = require 'querystring'
    data = qs.stringify
      app_id: process.env.HUBOT_GOO_API_TOKEN,
      sentence: msg.match[2],
      output_type: 'hiragana'
    msg.http("https://labs.goo.ne.jp/api/hiragana")
      .headers
        'Content-Type': 'application/x-www-form-urlencoded'
      .post(data) (err, res, body) ->
        msg.send JSON.parse(body)['converted']
