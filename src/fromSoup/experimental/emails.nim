import strutils, re

proc parseEmailAddressAI*(text: string): seq[string] {.exportc.} =
  ## This function takes a string containing a soup of text and
  ## returns a sequence of strings containing all the email addresses found in the text.
  var emails = newSeq[string]()
  let pattern = re"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}"
  let matches = re.findall(text, pattern)
  for match in matches:
    emails.add(match)
  return emails

proc parseEmails2(text: string): seq[string] =
  var emails: seq[string]
  for word in text.split:
    if word.contains('@'):
      let parts = word.split('@')
      if parts[0].len > 0 and parts[1].len > 0 and parts[1].contains('.'):
        emails.add(word)
    elif word.contains(" at "):
      let parts = word.split(" at ")
      if parts[0].len > 0 and parts[1].len > 0 and parts[1].contains('.'):
        emails.add(word.replace(" at ", "@"))
    elif word.contains("(at)"):
      let parts = word.split("(at)")
      if parts[0].len > 0 and parts[1].len > 0 and parts[1].contains('.'):
        emails.add(word.replace("(at)", "@"))
  return emails

echo parseEmails2("My email address is test@example.com, my other email is test at example.com, and my last one is test(at)example.com.")

when isMainModule and true:
  import benchy
  timeIt "ai":
    for ip in parseEmailAddressAI("foo firstname.lastname@domain.tld baa".repeat(1000)):
      keep ip