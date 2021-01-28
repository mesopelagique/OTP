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

### Verify HOTP

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

### Verify TOTP

You can verify the code with current timestamp

```4d
$isAuth:=$otp.verify(139664)
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

## Base32

To encode to base 32 without padding (ie. =) you could use

```4d
OTP.Base32.instance.encode($aSecretKeyBlob)
OTP.Base32.instance.encodeText($aSecretKeyText)
```

Code from [forum](https://discuss.4d.com/t/base32-encode-decode-in-native-4d/11129)

⚠️ seems to not encoded property all string

## Testing authenticator app with TOTP

### Download ones

- Google Authenticator [iOS](https://apps.apple.com/fr/app/google-authenticator/id388497605) [android](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=fr&gl=US)
- Microsoft Authenticator [iOS](https://apps.apple.com/fr/app/microsoft-authenticator/id983156458) [android](https://play.google.com/store/apps/details?id=com.azure.authenticator&hl=fr&gl=US)
- ...

### Scan a QR code with the app

Provide a QR Code with url provided by code 

```4d
$url:=$otp.provisioningUri("mesopelagique") // otpauth://totp/mesopelagique?secret=JDDK4U6G3BJLEZ7Y
```

You could generate QR code using [javascript](https://github.com/mesopelagique/form-login-SignInWithQRCode#present-a-qr-code-and-where) or temporary for test using a website like https://www.qr-code-generator.com/, https://www.unitag.io/fr/qrcode, ...

### Verify code

```4d
ASSERT($opt.verify(Int(Request("code?")); "Code is not ok")
```

Due to time drift, time could be different across devices and server and sometimes a code verify could failed.

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
