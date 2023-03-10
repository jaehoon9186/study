let input = readLine()!.split(separator: " ")
var (num1, num2) = (input[0], input[1])
print(max(Int(String(num1.reversed()))!, Int(String(num2.reversed()))!))
