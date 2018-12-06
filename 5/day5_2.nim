#Time to improve the polymer.
#
#One of the unit types is causing problems; it's preventing the polymer from
#collapsing as much as it should. Your goal is to figure out which unit type is
#causing the most problems, remove all instances of it (regardless of polarity),
#fully react the remaining polymer, and measure its length.
#
#For example, again using the polymer dabAcCaCBAcCcaDA from above:
#
#    - Removing all A/a units produces dbcCCBcCcD.
#        Fully reacting this polymer produces dbCBcD, which has length 6.
#    - Removing all B/b units produces daAcCaCAcCcaDA.
#        Fully reacting this polymer produces daCAcaDA, which has length 8.
#    - Removing all C/c units produces dabAaBAaDA.
#        Fully reacting this polymer produces daDA, which has length 4.
#    - Removing all D/d units produces abAcCaCBAcCcaA.
#        Fully reacting this polymer produces abCBAc, which has length 6.
#
#In this example, removing all C/c units was best, producing the answer 4.
#
#What is the length of the shortest polymer you can produce by removing all
#units of exactly one type and fully reacting the result?

import day5
import os, strutils, sequtils, strformat


proc remove_element(polymer: seq[char], element: char): seq[char] =
  # remove all instances of element (regardless of polarity) from the polymer
  var
    new_seq: seq[char]
  for i in polymer:
    if i.toLowerAscii != element.toLowerAscii:
      new_seq.add(i)
  return new_seq


when isMainModule:
  var
    polymer    = day5.read_input(os.paramStr(1)).toSeq
    tmp_polymer: seq[char]
    min        = polymer.len
  for element in 'a' .. 'z':
    tmp_polymer = polymer.remove_element(element)
    tmp_polymer = day5.repeated_reduce(tmp_polymer)
    if len(tmp_polymer) < min:
      min = len(tmp_polymer)
  echo min