#The Elves managed to locate the chimney-squeeze prototype fabric for Santa's
#suit (thanks to someone who helpfully wrote its box IDs on the wall of
#the warehouse in the middle of the night). Unfortunately, anomalies are
#still affecting them - nobody can even agree on how to cut the fabric.
#
#The whole piece of fabric they're working on is a very large square -
#at least 1000 inches on each side.
#
#Each Elf has made a claim about which area of fabric would be ideal for
#Santa's suit. All claims have an ID and consist of a single rectangle with
#edges parallel to the edges of the fabric. Each claim's rectangle is defined
#as follows:
#
#    The number of inches between the left edge of the fabric and the left edge
#    of the rectangle.
#    The number of inches between the top edge of the fabric and the top edge
#    of the rectangle.
#    The width of the rectangle in inches.
#    The height of the rectangle in inches.
#
#A claim like #123 @ 3,2: 5x4 means that claim ID 123 specifies a rectangle 3
#inches from the left edge, 2 inches from the top edge, 5 inches wide, and 4
#inches tall. Visually, it claims the square inches of fabric represented by
## (and ignores the square inches of fabric represented by .) in the diagram
#below:
#
#    ...........
#    ...........
#    ...#####...
#    ...#####...
#    ...#####...
#    ...#####...
#    ...........
#    ...........
#    ...........
#
#The problem is that many of the claims overlap, causing two or more claims
#to cover part of the same areas. For example, consider the following claims:
#
#    #1 @ 1,3: 4x4
#    #2 @ 3,1: 4x4
#    #3 @ 5,5: 2x2
#
#Visually, these claim the following areas:
#
#    ........
#    ...2222.
#    ...2222.
#    .11XX22.
#    .11XX22.
#    .111133.
#    .111133.
#    ........
#
#The four square inches marked with X are claimed by both 1 and 2.
#(Claim 3, while adjacent to the others, does not overlap either of them.)
#
#If the Elves all proceed with their own plans, none of them will have
#enough fabric. How many square inches of fabric are within two or more claims?

import os, strutils, sequtils, matrix


type
  Claim = tuple[ID  : int,
                loc : tuple[x: int, y: int],
                size: tuple[x: int, y: int]]


proc parse_input(path: string): seq[string] =
  for line in open(path, fmRead).lines:
    result.add(line)


proc parse_claim(input: string): Claim =
  # parse claim string into a tuple
  let # bit of a mess but it works
    split_str  = split(input, " ")
    id_str     = split_str[0]
    id         = parseInt(id_str[1 .. ^1])
    loc_split  = split_str[2].split(",")
    loc_x      = parseInt(loc_split[0])
    loc_y      = parseInt(loc_split[1][0 .. ^2])
    size_split = split_str[3].split("x")
    size_x     = parseInt(size_split[0])
    size_y     = parseInt(size_split[1])
  return (id, (loc_x, loc_y), (size_x, size_y))


proc create_coords(claim: Claim): seq[array[2, int]] =
  # from a Claim create all x,y co-ordinates
  let
    (start_x, start_y) = claim.loc
    lim_x = start_x + claim.size.x - 1
    lim_y = start_y + claim.size.y - 1
  for i in start_x .. lim_x:
    for j in start_y .. lim_y:
      result.add([i, j])


proc create_section(coords: seq[array[2, int]]): Matrix =
  var
    matrix = zero_matrix(1000, 1000)
  for pos in coords:
    # flipped as measuring from the top of the array
    matrix[pos[1]][pos[0]] = 1
  return matrix


proc find_overlap_area(x: Matrix): int =
  for i in 0 .. x.shape[0]-1:
    for j in 0 .. x.shape[1]-1:
      if x[i][j] > 1:
        result += 1


if isMainModule:
  let
    sections = paramStr(1)
      .parse_input
      .map(parse_claim)
      .map(create_coords)
      .map(create_section)
    total = foldl(sections, a + b)
  echo find_overlap_area(total)
