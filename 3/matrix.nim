type
  Matrix* = seq[seq[int]]


proc zero_matrix*(n: int, m: int): Matrix =
  # create an n*m matrix of zeros
  var
    column = newSeq[int](n+1)
    matrix : Matrix
  for i in 0..n:
    matrix.add(column)
  return matrix


proc echo*(x: Matrix) =
  echo "["
  for i in x:
    echo i
  echo "]"


proc shape*(x: Matrix): array[2, int] =
  return [len(x), len(x[0])]


proc `+`*(a: Matrix, b: Matrix): Matrix =
  var
    width  = high(a)
    height = high(a[0])
    output = zero_matrix(width, height)
  for i in 0..len(a)-1:
    for j in 0..len(a[0])-1:
      output[i][j] = a[i][j] + b[i][j]
  return output