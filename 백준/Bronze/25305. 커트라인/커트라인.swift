let input = readLine()!.split(separator: " ").map { Int($0)! }
let (count, award) = (input[0], input[1])
let points = readLine()!.split(separator: " ").map { Int($0)! }

print(points.sorted(by: >)[award - 1])
