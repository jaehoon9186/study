let input = Int(readLine()!)!
var answer = 0
var i = 1

// 제곱수는 약수의 개수가 홀수 이다.

while i * i <= input {
    answer += 1
    i += 1
}

print(answer)
