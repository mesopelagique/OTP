# OTP

[![language][code-shield]][code-url]
[![language-top][code-top]][code-url]
![code-size][code-size]
[![release][release-shield]][release-url]
[![license][license-shield]][license-url]
[![discord][discord-shield]][discord-url]

Generate [one-time passwords(OTP)](https://en.wikipedia.org/wiki/One-time_password)

This is compatible with apps available for Android and iPhone.
> For that provide the secret key or an url in QR code for instance 

## HOTP [RFC 4226](http://tools.ietf.org/html/rfc4226)

Create an `HOTP` instance with our secret key encoded to base32(without pading ie. =)

```4d
$otp:=OTP.HOTP.new("JDDK4U6G3BJLEZ7Y") // base32 encoded key
```

Maintain a counter for a user, to change its value at each try.

### Verify

You can verify the code according to a counter

```4d
$isAuth:=$otp.verify(654666; 1500)
```

### Get a code

You can get the code passing the current counter, to display it or send it by email or [sms](https://github.com/mesopelagique/Twilio)

```4d
$code:=$otp.at(1500)
```

### Get URL for auth app

```4d
$url:=$otp.provisioningUri("my app";$currentCounter)
```

## TOTP [RFC 6238](http://tools.ietf.org/html/rfc6238)

Create an `TOTP` instance with our secret key encoded to base32(without pading ie. =)

```4d
$otp:=OTP.TOTP.new("JDDK4U6G3BJLEZ7Y")
```

TOTP allow to not manage a counter by using the current time stamp instead

### Verify 

You can verify the code with current timestamp

```4d
$isAuth:=$otp.verify(139664) // TODO check if could be tested without affected it
```

or a specific timestamp to test

```4d
$isAuth:=$otp.verify(139664;1301012137)
```

### Get

You can get the current code, to display it or send it by email or [sms](https://github.com/mesopelagique/Twilio)

```4d
$code:=$otp.now()
```

You can also get it for a specific time stamp

```4d
$code:=$o.at(1301012137)
```

### Get URL for auth app

```4d
$url:=$otp.provisioningUri("my app")
```

## Other components

[<img src="https://mesopelagique.github.io/quatred.png" alt="mesopelagique"/>](https://mesopelagique.github.io/)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[code-shield]: https://img.shields.io/static/v1?label=language&message=4d&color=blue
[code-top]: https://img.shields.io/github/languages/top/mesopelagique/OTP.svg
[code-size]: https://img.shields.io/github/languages/code-size/mesopelagique/OTP.svg
[code-url]: https://developer.4d.com/
[release-shield]: https://img.shields.io/github/v/release/mesopelagique/OTP
[release-url]: https://github.com/mesopelagique/OTP/releases/latest
[license-shield]: https://img.shields.io/github/license/mesopelagique/OTP
[license-url]: LICENSE.md
[discord-shield]: https://img.shields.io/badge/chat-discord-7289DA?logo=discord&style=flat
[discord-url]: https://discord.gg/dVTqZHr
