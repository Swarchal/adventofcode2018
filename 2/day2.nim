#You stop falling through time, catch your breath, and check the screen on
#the device. "Destination reached. Current Year: 1518. Current Location:
#North Pole Utility Closet 83N10." You made it! Now, to find those anomalies.
#
#Outside the utility closet, you hear footsteps and a voice.
#"...I'm not sure either. But now that so many people have chimneys, maybe
#he could sneak in that way?" Another voice responds, "Actually, we've been
#working on a new kind of suit that would let him fit through tight spaces
#like that. But, I heard that a few days ago, they lost the prototype fabric,
#the design plans, everything! Nobody on the team can even seem to remember
#important details of the project!"
#
#"Wouldn't they have had enough fabric to fill several boxes in the warehouse?
#They'd be stored together, so the box IDs should be similar. Too bad it would
#take forever to search the warehouse for two similar box IDs..." They walk
#too far away to hear any more.
#
#Late at night, you sneak to the warehouse - who knows what kinds of paradoxes
#you could cause if you were discovered - and use your fancy wrist device to
#quickly scan every box and produce a list of the likely candidates (your
#puzzle input).
#
#To make sure you didn't miss any, you scan the likely candidate boxes again,
#counting the number that have an ID containing exactly two of any letter and
#then separately counting those with exactly three of any letter. You can
#multiply those two counts together to get a rudimentary checksum and compare
#it to what your device predicts.
#
#For example, if you see the following box IDs:
#
#    abcdef contains no letters that appear exactly two or three times.
#    bababc contains two a and three b, so it counts for both.
#    abbcde contains two b, but no letter appears exactly three times.
#    abcccd contains three c, but no letter appears exactly two times.
#    aabcdd contains two a and two d, but it only counts once.
#    abcdee contains two e.
#    ababab contains three a and three b, but it only counts once.
#
#Of these box IDs, four of them contain a letter which appears exactly twice,
#and three of them contain a letter which appears exactly three times.
#Multiplying these together produces a checksum of 4 * 3 = 12.
#
#What is the checksum for your list of box IDs?

import os, sequtils, strutils, tables


type
  Count = tuple[double: int, triple: int]


proc parse_file(path: string): seq[string] =
  for line in open(path, fmRead).lines:
    result.add(line)


func get_counts(box_id: string): Count =
  var
    doubles = 0
    triples = 0
  for key, value in box_id.toCountTable():
    if value == 2:
      doubles = 1
    if value == 3:
      triples = 1
  return (doubles, triples)


proc sum_counts(count_list: seq[Count]): int =
  var
    doubles_count = 0
    triples_count = 0
    count         : Count
  for count in count_list:
    doubles_count += count.double
    triples_count += count.triple
  return doubles_count * triples_count


when isMainModule:
  let input = parse_file(paramStr(1))
  echo input.map(get_counts).sum_counts()

