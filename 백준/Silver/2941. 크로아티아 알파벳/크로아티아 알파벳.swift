let inputArray = Array(readLine()!)
let croatiaAlphabet = ["c=", "c-", "dz=", "d-", "lj", "nj", "s=", "z="]
var count = 0
var idx = 0

while idx < inputArray.count {

    var flag = 0

    // 특수문자
    for i in (2...3) {
        if idx + i <= inputArray.count && croatiaAlphabet.contains(inputArray[idx..<idx + i].map { String($0) }.joined()) {
            idx += i
            count += 1
            flag = 1
            break
        }
    }

    // 일반문자
    if flag == 0 {
        idx += 1
        count += 1
    }
}

print(count)
