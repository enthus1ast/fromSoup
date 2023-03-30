import strutils

proc isHexadecimal(s: string): bool =
  for c in s.toLower:
    if not (c in "0123456789abcdef"):
      return false
  return true

proc parseIPv6Addresses(text: string): seq[string] =
  var ipv6Addresses: seq[string]
  for word in text.split:
    if word.len > 7 and word.contains(':'):
      let parts = word.split(':')
      var valid = true
      for part in parts:
        if part.len > 4 or not isHexadecimal(part):
          valid = false
      if valid:
        ipv6Addresses.add(word)
  return ipv6Addresses

echo parseIPv6Addresses("My ipv6 address is 2001:0db8:85a3:0000:0000:8a2e:0370:7334")