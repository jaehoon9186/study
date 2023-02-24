let input = Int(readLine()!)!

print(input % 400 == 0 ? "1" : input % 4 == 0 && input % 100 != 0 ? "1" : "0")
