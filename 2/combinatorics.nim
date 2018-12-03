proc repeatedPermutations[T](a: openarray[T], n: int): seq[seq[T]] =
    result = newSeq[seq[T]]()
    if n <= 0: return
    for i in 0 .. a.high:
      if n == 1:
        result.add(@[a[i]])
      else:
        for j in repeatedPermutations(a, n - 1):
          result.add(a[i] & j)

proc perm[T](a: openarray[T], n: int, use: var seq[bool]): seq[seq[T]] =
  result = newSeq[seq[T]]()
  if n <= 0: return
  for i in 0 .. a.high:
    if not use[i]:
      if n == 1:
          result.add(@[a[i]])
      else:
        use[i] = true
        for j in perm(a, n - 1, use):
          result.add(a[i] & j)
        use[i] = false

proc permutations*[T](a: openarray[T], n: int): seq[seq[T]] =
  var use = newSeq[bool](a.len)
  perm(a, n, use)


proc comb[T](a: openarray[T]; n: int; use: seq[bool]): seq[seq[T]] =
  result = newSeq[seq[T]]()
  var use = use
  if n <= 0: return
  for i in 0  .. a.high:
    if not use[i]:
      if n == 1:
        result.add(@[a[i]])
      else:
        use[i] = true
        for j in comb(a, n - 1, use):
          result.add(a[i] & j)

proc combinations*[T](a: openarray[T], n: int): seq[seq[T]] =
  var use = newSeq[bool](a.len)
  comb(a, n, use)

proc rcomb[T](a: openarray[T]; n: int; use: seq[bool]): seq[seq[T]] =
  result = newSeq[seq[T]]()
  var use = use
  if n <= 0: return
  for i in 0  .. a.high:
    if not use[i]:
      if n == 1:
        result.add(@[a[i]])
      else:
        for j in rcomb(a, n - 1, use):
          result.add(a[i] & j)
        use[i] = true

proc repeatedCombinations[T](a: openarray[T], n: int): seq[seq[T]] =
  var use = newSeq[bool](a.len)
  rcomb(a, n, use)

# now we try to make an iterator
iterator repeatedPermutation[T](a: openarray[T], n: int): seq[T] =
  for i in 0 .. a.high:
    if n == 1:
      yield @[a[i]]
    else:
      for j in repeatedPermutations(a, n - 1):
        for k in j:
          yield @[a[i]] & k
