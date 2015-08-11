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
fs = require 'fs'

exports.name = 'verify-email'

exports.plugin = (VaporAPI) ->
  log = VaporAPI.getLogger()

  VaporAPI.registerHandler {emitter: 'vapor', event: 'cookies'}, (cookies) ->
    options =
      url: 'https://store.steampowered.com/twofactor/manage_action'
      method: 'POST'
      form:
        sessionid: cookies[0].split('=')[1]
        action: 'email'
        email_authenticator_check: 'on'
      headers:
        'Cookie': cookies.join("; ")
    fs.exists this.sentryFilePath, (exists) ->
      if (!exists) # If our sentry file doesn't exist, we need to enable steamguard.
        request options, (err, resp, body) ->
          log.info 'Restarting to verify email.'
          VaporAPI.disconnect()

          setTimeout ->
            VaporAPI.connect()
          , 5000