# import strutils, strformat

# proc parseIPv4(text: string): string {.exportc.} =
#   var address = newString(15)
#   let parts = text.split(".")
#   if parts.len != 4:
#     return ""
#   for i in 0..3:
#     if parts[i].parseInt > 255:
#       return ""
#     address &= $chr(parts[i].parseInt)
#   return address

# let text = "192.168.1.1"
# let parsedAddress = parseIPv4(text)
# echo parsedAddress # Outputs: C0A80101


import strutils, re

proc parseIPv4(text: string): seq[string] {.exportc.} =
  var ipAddresses = newSeq[string]()
  let pattern = re"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
  let matches = re.findall(text, pattern)
  for match in matches:
    ipAddresses.add(match)
  return ipAddresses


proc isInt(s: string): bool =
  for c in s:
    if not (c in "0123456789"):
      return false
  return true

proc parseIPv42(text: string): seq[string] =
  var ipAddresses: seq[string]
  for word in text.split:
    var numParts = 0
    var valid = true
    for part in word.split('.'):
      if not isInt(part) or part.len > 3:
        valid = false
      else:
        numParts += 1
    if numParts == 4 and valid:
      ipAddresses.add(word)
  return ipAddresses



import strutils


proc parseIPv43(text: string): seq[string] =
  var ipAddresses: seq[string]
  var currentIP = ""
  var numParts = 0
  for c in text:
    if c == '.' or c == ' ':
      if numParts == 3 and isInt(currentIP) and currentIP.len < 4:
        ipAddresses.add(currentIP)
      currentIP = ""
      numParts = 0
    else:
      currentIP &= c
      numParts += 1
  if numParts == 3 and isInt(currentIP) and currentIP.len < 4:
    ipAddresses.add(currentIP)
  return ipAddresses

echo parseIPv4("My ip address is 192.168.1.1")



import benchy

timeIt "regex":
  keep parseIPv4("My ip address is 192.168.1.1".repeat(1000))

timeit "no regex":
  keep parseIPv42("My ip address is 192.168.1.1".repeat(1000))

timeit "no regex2":
  keep parseIPv43("My ip address is 192.168.1.1".repeat(1000))

# parseIPv43
echo parseIPv4("asd192.168.1.1asdasd192.168.1.1asdasd192.168.1.1asd")