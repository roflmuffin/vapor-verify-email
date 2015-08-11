[![NPM version](http://img.shields.io/npm/v/vapor-verify-email.svg?style=flat)](https://www.npmjs.org/package/vapor-verify-email)
[![Dependency Status](https://david-dm.org/roflmuffin/vapor-verify-email.svg)](https://david-dm.org/roflmuffin/vapor-verify-email)

# Vapor Verify Email Plugin

[Vapor](https://github.com/scholtzm/vapor) plugin to enable steamguard and as a result, verify email.

Arguably, this plugin could also simply be called enable-steamguard or some such as all it really does is enable SteamGuard without having to visit the website and restart your bot.

### Installation

```
npm install vapor-verify-email
```

### Usage

```js
var verifyEmail = require('vapor-verify-email');

// Instantiate Vapor etc.

Vapor.use(verifyEmail);
```

### Features

- Enables SteamGuard through entire through a web session (no manual logging in required).
- Upon first entry of SteamGuard code, account will become now email verified!

Simplifies the entire SteamGuard email verification process through an entirely automated procedure. Instead of having to login to the account, enable SteamGuard, login to the steam application etc., you can simply activate this plugin and input the SteamGuard code once.

Due to the fact that entering a SteamGuard code proves that you are the owner of the email associated with the account, it sets your accounts email verification status to `Verified`.

Best used with an automatic SteamGuard code response plugin, like one shown [here](https://github.com/scholtzm/vapor/tree/master/examples/custom-steamguard). This makes creating and verifying new accounts extremely easy!

### License

MIT. See `LICENSE`.
