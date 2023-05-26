let input = Int(readLine()!)!
var list: [Int] = []
list.append(0)
list.append(1)
list.append(2)

if input >= 3 {
    for i in 3...input + 1 {
        let tmp = (list[i-1] + list[i-2]) % 15746
        list.append(tmp)
    }
}

print(list[input])
