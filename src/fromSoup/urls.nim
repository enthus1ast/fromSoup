import strutils, re

proc parseURLAddressAI(text: string): seq[string] {.exportc.} =
  ## This function takes a string containing a soup of text
  ## and returns a sequence of strings containing all the URL addresses found in the text.
  var urls = newSeq[string]()
  let pattern = re"(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?"
  let matches = re.findall(text, pattern)
  for match in matches:
    urls.add(match)
  return urls


when true:
  echo parseURLAddressAI("foo https://firstname.lastname/baa?bla=blubb&haha=trala haha".repeat(2))
  import benchy
  # timeIt "ai":
  #   for ip in parseURLAddressAI("foo https://firstname.lastname/baa haha".repeat(1000)):
  #     keep ip