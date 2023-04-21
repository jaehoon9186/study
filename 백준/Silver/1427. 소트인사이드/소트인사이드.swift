var input = Array(readLine()!)

print(input.sorted(by: >).map { String($0) }.joined())

