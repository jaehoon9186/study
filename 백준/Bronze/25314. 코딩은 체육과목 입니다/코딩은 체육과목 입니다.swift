let input = Int(readLine()!)!
var type = "int"

// input이 4 이상임을 고려함. 따라서 예외처리 안함.
for _ in 1...(input/4) {
    type = "long " + type
}

print(type)
