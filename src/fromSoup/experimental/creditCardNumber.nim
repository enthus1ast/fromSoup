import strutils, re

# proc parseCreditCardNumber(text: string): seq[string] {.exportc.} =
#   ## Parses credit card numbers from a soup of text.
#   ## The parser can parse credit card numbers separated with a space, hyphen, or no separator at all, as well as numbers with no separator.
#   var cardNumbers = newSeq[string]()
#   let pattern = re"([0-9]{4}-?[0-9]{4}-?[0-9]{4}-?[0-9]{4}|[0-9]{13,16})"
#   let matches = re.findall(text, pattern)
#   for match in matches:
#     cardNumbers.add(match)
#   return cardNumbers

proc parseCreditCardNumber(text: string): seq[string] {.exportc.} =
  ## Parses credit card numbers from a soup of text.
  ## The parser can parse credit card numbers separated with a space, hyphen, or no separator at all, as well as numbers with no separator.
  var cardNumbers = newSeq[string]()
  let pattern = re"([0-9]{4}-?[0-9]{4}-?[0-9]{4}-?[0-9]{4}|[0-9]{11,16})"
  let matches = re.findall(text, pattern)
  for match in matches:
    cardNumbers.add(match)
  return cardNumbers


var ttt = """
Credit Card Type

Credit Card Number

American Express

378282246310005

American Express

371449635398431

American Express Corporate

378734493671000

Australian BankCard

5610591081018250

Diners Club

30569309025904

Diners Club

38520000023237

Discover

6011111111111117

Discover

6011000990139424

JCB

3530111333300000

JCB

3566002020360505

MasterCard

5555555555554444

MasterCard

5105105105105100

Visa

4111111111111111

Visa

4012888888881881

Visa

4222222222222

Note : Even though this number has a different character count than the other test numbers, it is the correct and functional number.

Processor-specific Cards

Dankort (PBS)

76009244561

Dankort (PBS)

5019717010103742

Switch/Solo (Paymentech)

6331101999990016
"""

let cards =  parseCreditCardNumber(ttt)
echo cards
echo cards.len
assert cards.len == 18
assert cards == @["378282246310005", "371449635398431", "378734493671000", "5610591081018250", "30569309025904", "38520000023237", "6011111111111117", "6011000990139424", "3530111333300000", "3566002020360505", "5555555555554444", "5105105105105100", "4111111111111111", "4012888888881881", "4222222222222", "76009244561", "5019717010103742", "6331101999990016"]