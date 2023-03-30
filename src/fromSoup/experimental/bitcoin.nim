import strutils, parseutils
type
  BitcoinAddress = string
  BitcoinAddressToken = tuple[str: string, spos: int, epos: int]
const validChars = {'a'..'z'} + {'A'..'H'} + {'J'..'N'} + {'P'..'Z'} + {'0'..'9'}

proc parse(str: string): seq[BitcoinAddress] =
  for word in str.splitWhitespace():
    var isValid = true
    if word.len < 26 or word.len > 35 or word.len == 0: continue
    if not (word[0] == '1' or word[0] == '3' or word[0..2] == "bc1"): continue
    for ch in word:
      if ch notin validChars:
        isValid = false
        break
    if isValid: result.add word

proc parse2(str: string): seq[BitcoinAddressToken] =
  var pos = 0
  var word: string
  while pos < str.len:
    pos += str.parseUntil(word, Whitespace, pos)
    var isValid = true
    if word.len < 26 or word.len > 35 or word.len == 0:
      pos.inc
      continue
    if not (word[0] == '1' or word[0] == '3' or word[0..2] == "bc1"):
      pos.inc
      continue
    for ch in word:
      if ch notin validChars:
        isValid = false
        break
    if isValid: result.add (word, pos - (word.len + 1), pos)
    # pos += str.skip(" ", pos)
    pos.inc

proc replaceBitcoinAddr(str: string, myAddr = "1fffffffffffffffffffffffffffffffff"): string =
  ## replaces the FIRST bitcoin address with the one from myAddr
  let addresses = str.parse2()
  if addresses.len == 0: return str
  let pref = str[0 .. addresses[0].spos]
  let suf = str[addresses[0].epos .. ^1]
  return pref & myAddr & suf


when isMainModule:

  let tst = """1KFHE7w8BhaENAswwryaoccDb6qcT6DbYY loremipsum
16ftSEQ4ctQFDtVZiUBusQUjRrGhM3JYwe
1EBHA1ckUWzNKN7BMfDwGTx6GKEbADUozX
0xde0b295669a9fd93d5f28d9ec85e40f4cb697bae
bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq
"""

  let tst2 = tst.repeat(1000)

  import benchy
  # echo parse2(tst)
  timeit "old":
    discard parse(tst2)
  timeit "new":
    discard parse2(tst2)
  timeit "repl":
    discard replaceBitcoinAddr(tst2)

