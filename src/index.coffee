###
# Uses a Web Session to enable SteamGuard through the steam website.
#
# When a SteamGuard code is entered, it automatically verifies the email.
# Verified email is important for numerous bots.
#
# @example
# bot.use(require('vapor-verify-email'))
# @param {Object} VaporAPI Instance of the API class.
# @module
#
###

request = require 'request'

exports.name = 'verify-email'

exports.plugin = (VaporAPI) ->
  Steam = VaporAPI.getSteam()
  emailValidated = false

  VaporAPI.registerHandler {emitter: 'client', event: 'logOnResponse'}, (response) ->
    if response.eresult == Steam.EResult.OK
      emailValidated = response.account_flags & Steam.EAccountFlags.EmailValidated

  VaporAPI.registerHandler {emitter: 'vapor', event: 'cookies'}, (cookies, sessionid) ->
    options =
      url: 'https://store.steampowered.com/twofactor/manage_action'
      method: 'POST'
      form:
        sessionid: sessionid
        action: 'email'
        email_authenticator_check: 'on'
      headers:
        'Cookie': cookies.join("; ")

    if !emailValidated # If our email isn't validated, send our request and restart the bot
      request options, (err, resp, body) ->
        VaporAPI.emitEvent('message:info', 'Restarting to verify email.')
        VaporAPI.disconnect()

        setTimeout ->
          VaporAPI.connect()
        , 5000