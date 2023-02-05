import strscans
import strutils
import formatja

proc hexByte(input: string, ret: var int, start: int): int =
  let hb = input[start .. start + 1]
  try:
    ret = parseHexInt(hb)
    result = 2
  except:
    result = 0

proc mySep(input: string, start: int): int =
  case input[start]
  of '-', ':': return 1
  else: return 0

iterator parseMacs*(soup: string, outputSeperator = ':'): string =
  var a,b,c,d,e,f: int
  var buf: string = ""
  var idx = 0
  var toIdx: int
  var ch: char

  while idx < soup.len:
    ch = soup[idx]
    if ch in HexDigits:
      try:
        if idx + 16 < soup.len:
          toIdx = idx + 16
        else:
          toIdx = soup.len - 1

        let buff = soup[idx..toIdx]
        # echo buff
        # if soup[idx..toIdx].scanf("${hexByte}$[mySep]${hexByte}$[mySep]${hexByte}$[mySep]${hexByte}$[mySep]${hexByte}$[mySep]${hexByte}", a,b,c,d,e,f):

        if buff.scanf("${hexByte}-${hexByte}-${hexByte}-${hexByte}-${hexByte}-${hexByte}", a,b,c,d,e,f) or
            buff.scanf("${hexByte}:${hexByte}:${hexByte}:${hexByte}:${hexByte}:${hexByte}", a,b,c,d,e,f):
          # buf.setLen(0)
          buf = format("{{a}}{{sep}}{{b}}{{sep}}{{c}}{{sep}}{{d}}{{sep}}{{e}}{{sep}}{{f}}", {
            "sep": $outputSeperator,
            "a": $a.toHex(2),
            "b": $b.toHex(2),
            "c": $c.toHex(2),
            "d": $d.toHex(2),
            "e": $e.toHex(2),
            "f": $f.toHex(2),
          })
          # echo "->", buf
          if (a > 255 or a < 0)  or
             (b > 255 or b < 0)  or
             (c > 255 or c < 0)  or
             (d > 255 or d < 0)  or
             (e > 255 or e < 0)  or
             (f > 255 or f < 0)  :
            idx.inc(buf.len) # skip the bytes we've just read in
            # idx.inc
            continue
          yield buf
          idx.inc buf.len - 1
      except Exception as exp:
        discard
    idx.inc


when isMainModule and true:
  import sequtils
  # echo toSeq(parseMacs("asdfA0-AF-BD-9A-31-B5A0-AF-BD-9A-31-B5A0-AF-BD-9A-31-B5adf"))
  echo toSeq(parseMacs("asdfA0:AF:BD:9A:31:B5adf"))
  echo toSeq(parseMacs("asdfA0-AF-BD-9A-31-B5adf"))
  assert toSeq(parseMacs("asdfA0-AF-BD-9A-31-B5adf")) == @["A0:AF:BD:9A:31:B5"]
  assert toSeq(parseMacs("asdfA0:AF:BD:9A:31:B5adf")) == @["A0:AF:BD:9A:31:B5"]
  assert toSeq(parseMacs("asdfA0-AF-BD-9A-31-B5adf", outputSeperator='-')) == @["A0-AF-BD-9A-31-B5"]
  assert toSeq(parseMacs("asdfA0:AF:BD:9A:31:B5adf", outputSeperator='-')) == @["A0-AF-BD-9A-31-B5"]
  # assert toSeq(parseIps "hasjhaskh998.197.89.196jasdjkl193.197.89.196ajs193.197.89.196dklaj") == @["193.197.89.196", "193.197.89.196"]
  # assert toSeq(parseIps "hasskh196jasdjkl19.196ajs193..196dklajsdk81.") == @[]
  # assert toSeq(parseIps "93.194.255.234") == @["93.194.255.234"]
  # import strformat
  # for ip in parseIps readFile("""C:\Users\david\Documents\DURCHBLICK.graphml"""):
  #   echo fmt"""("{ip}", "TODO add entity", "ping {ip}"),"""
when isMainModule and false:
  import sequtils
  import osproc
  echo toSeq(parseMacs(execCmdEx("ipconfig /all").output))
