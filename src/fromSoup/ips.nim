import strscans
import strutils

iterator parseIps*(soup: string): string =
  ## ipv4 only!
  var a,b,c,d : int
  var buf: string = ""
  var idx = 0
  var toIdx: int
  var ch: char

  while idx < soup.len:
    ch = soup[idx]
    if ch in Digits:
      try:
        if idx + 16 < soup.len:
          toIdx = idx + 16
        else:
          toIdx = soup.len - 1
        if soup[idx..toIdx].scanf("$i.$i.$i.$i", a,b,c,d):
          # buf.setLen(0)
          buf = "$1.$2.$3.$4" % [$a,$b,$c,$d]
          if (a > 255 or a < 0)  or
             (b > 255 or b < 0)  or
             (c > 255 or c < 0)  or
             (d > 255 or d < 0)  :
             idx.inc(buf.len) # skip the bytes we've just read in
             continue
          yield buf
          idx.inc buf.len
      except Exception as exp:
        discard
    idx.inc


when isMainModule:
  import sequtils
  assert toSeq(parseIps "hasjhaskh998.197.89.196jasdjkl193.197.89.196ajs193.197.89.196dklaj") == @["193.197.89.196", "193.197.89.196"]
  assert toSeq(parseIps "hasskh196jasdjkl19.196ajs193..196dklajsdk81.") == @[]
  assert toSeq(parseIps "93.194.255.234") == @["93.194.255.234"]




when isMainModule and true:
  import strutils, re

  proc parseIPv4AI(text: string): seq[string] {.exportc.} =
    var ipAddresses = newSeq[string]()
    let pattern = re"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
    let matches = re.findall(text, pattern)
    for match in matches:
      ipAddresses.add(match)
    return ipAddresses
  import benchy
  timeIt "me":
    for ip in parseIps "hasjhaskh998.197.89.196jasdjkl193.197.89.196ajs193.197.89.196dklaj".repeat(1000):
      keep ip
  timeIt "ai":
    for ip in parseIPv4AI("hasjhaskh998.197.89.196jasdjkl193.197.89.196ajs193.197.89.196dklaj".repeat(1000)):
      keep ip