#Confident that your list of box IDs is complete, you're ready to find the
#boxes full of prototype fabric.
#
#The boxes will have IDs which differ by exactly one character at the same
#position in both strings. For example, given the following box IDs:
#
#    abcde
#    fghij
#    klmno
#    pqrst
#    fguij
#    axcye
#    wvxyz
#
#The IDs abcde and axcye are close, but they differ by two characters
#(the second and fourth). However, the IDs fghij and fguij differ by exactly
#one character, the third (h and u). Those must be the correct boxes.
#
#What letters are common between the two correct box IDs? (In the example
#above, this is found by removing the differing character from either ID,
#producing fgij.)
#
#Confident that your list of box IDs is complete, you're ready to find the
#boxes full of prototype fabric.
#
#The boxes will have IDs which differ by exactly one character at the same
#position in both strings. For example, given the following box IDs:
#
#    abcde
#    fghij
#    klmno
#    pqrst
#    fguij
#    axcye
#    wvxyz
#
#The IDs abcde and axcye are close, but they differ by two characters (the
#second and fourth). However, the IDs fghij and fguij differ by exactly one
#character, the third (h and u). Those must be the correct boxes.
#
#What letters are common between the two correct box IDs? (In the example
#above, this is found by removing the differing character from either ID,
#producing fgij.)

import os, strutils, sequtils, strutils, combinatorics


proc parse_file(path: string): seq[string] =
  for line in open(path, fmRead).lines:
    result.add(line)


proc hamming_distance(x: string, y: string): int =
  var
    dist = 0
    i    : (char, char)
  for i in zip(x, y):
    dist += int(i.a != i.b)
  return dist


proc find_close_ids(ids: seq[string]): seq[string] =
  let pairs = combinatorics.combinations(ids, 2)
  for pair in pairs:
    if hamming_distance(pair[0], pair[1]) == 1:
      result.insert(pair)


proc find_common_string(pair: seq[string]): string =
  for i in zip(pair[0], pair[1]):
    if i.a == i.b:
      result.add(i.a)


when isMainModule:
  var
    input = parse_file(paramStr(1))
    close_ids = find_close_ids(input)
    common_string = find_common_string(close_ids)
  echo common_string

