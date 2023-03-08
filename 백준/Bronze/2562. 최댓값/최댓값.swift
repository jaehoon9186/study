var maxNumber = (0, 0)

for i in (1...9) {
    if let number = Int(readLine()!) {
        maxNumber = maxNumber.1 < number ? (i, number) : maxNumber
    }
}

print(maxNumber.1)
print(maxNumber.0)
