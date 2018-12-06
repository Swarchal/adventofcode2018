#You've managed to sneak in to the prototype suit manufacturing lab. The Elves
#are making decent progress, but are still struggling with the suit's size
#reduction capabilities.
#
#While the very latest in 1518 alchemical technology might have solved their
#problem eventually, you can do better. You scan the chemical composition of
#the suit's material and discover that it is formed by extremely long polymers
#(one of which is available as your puzzle input).
#
#The polymer is formed by smaller units which, when triggered, react with each
#other such that two adjacent units of the same type and opposite polarity are
#destroyed. Units' types are represented by letters; units' polarity is
#represented by capitalization. For instance, r and R are units with the same
#type but opposite polarity, whereas r and s are entirely different types and
#do not react.
#
#For example:
#
#    - In aA, a and A react, leaving nothing behind.
#    - In abBA, bB destroys itself, leaving aA. As above, this then destroys
#      itself, leaving nothing.
#    - In abAB, no two adjacent units are of the same type, and so nothing
#      happens.
#    - In aabAAB, even though aa and AA are of the same type, their polarities
#      match, and so nothing happens.
#
#Now, consider a larger example, dabAcCaCBAcCcaDA:
#
#dabAcCaCBAcCcaDA  The first 'cC' is removed.
#dabAaCBAcCcaDA    This creates 'Aa', which is removed.
#dabCBAcCcaDA      Either 'cC' or 'Cc' are removed (the result is the same).
#dabCBAcaDA        No further actions can be taken.
#
#After all possible reactions, the resulting polymer contains 10 units.
#
#How many units remain after fully reacting the polymer you scanned?

import os, strutils, sequtils, strformat

proc read_input*(path: string): string =
  var output: seq[string]
  for line in open(path).lines:
    output.add(line)
  return output[0]


proc to_seq*(x: string): seq[char] =
  for i in x:
    result.add(i)


func is_shorter_than*(new_str: seq[char], orig_str: seq[char]): bool =
  return new_str.len < orig_str.len


func is_reactive*(diatom: seq[char]): bool =
  assert len(diatom) == 2
  var
    all_lower = diatom.map(toLowerAscii)
  if all_lower[0] != all_lower[1]:
    # not the same atom
    return false
  else:
    if diatom[0].isLowerAscii and diatom[1].isUpperAscii:
      # same atom and different polarity (aA)
      return true
    elif diatom[0].isUpperAscii and diatom[1].isLowerAscii:
      # same atom and different polarity (Aa)
      return true
    else:
      # must be the same case
      return false


proc reduce*(polymer: seq[char]): seq[char] =
  var
    polymer = polymer
  for i in 0 .. polymer.high - 1:
    if polymer[i..i+1].is_reactive:
      polymer.delete(i, i+1)
      break
  return polymer

proc repeated_reduce*(polymer: seq[char]): seq[char] =
  var
    current_polymer = polymer
    last_polymer    = polymer
    still_reducing  = true
  while still_reducing:
    last_polymer    = current_polymer
    current_polymer = day5.reduce(current_polymer)
    still_reducing  = current_polymer.is_shorter_than(last_polymer)
  return current_polymer


when isMainModule:
  var
    polymer = read_input(os.paramStr(1)).toSeq
  echo polymer.repeated_reduce.len
