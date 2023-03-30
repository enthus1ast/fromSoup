import strutils

# proc parsePhoneNumbers(text: string): seq[string] =
#   var phoneNumbers: seq[string]
#   for word in text.split:
#     if word.len > 7 and strutils.isDigit(word[0]):
#       if word.contains('-') and word.count('-') == 2:
#         let nums = word.split('-')
#         if nums[0].len == 3 and nums[1].len == 3 and nums[2].len == 4:
#           phoneNumbers.add(word)
#       elif word.contains('(') and word.contains(')'):
#         let nums = word.split('(')[1].split(')')
#         if nums[0].len == 3 and nums[1].len == 3 and nums[2].len == 4:
#           phoneNumbers.add(word)
#   return phoneNumbers

# echo parsePhoneNumbers("Call us at (123)456-7890 or 123-456-7890")

import strutils

proc parsePhoneNumbers(text: string): seq[string] =
  var phoneNumbers: seq[string]
  for word in text.split:
    if word.len > 7 and strutils.isDigit(word[0]):
      if word.contains('-') and word.count('-') == 2:
        let nums = word.split('-')
        if nums[0].len == 3 and nums[1].len == 3 and nums[2].len == 4:
          phoneNumbers.add(word)
      elif word.contains('(') and word.contains(')'):
        let nums = word.split('(')[1].split(')')
        if nums[0].len == 3 and nums[1].len == 3 and nums[2].len == 4:
          phoneNumbers.add(word)
      elif word.contains('+') and word.count('+') == 1:
        let nums = word.split('+')
        if nums[1].len == 10 and nums[2].len == 3 and nums[3].len == 3 and nums[4].len == 4:
          phoneNumbers.add(word)
  return phoneNumbers


echo parsePhoneNumbers("Call us at (123)456-7890, +491234567890 or 123-456-7890")