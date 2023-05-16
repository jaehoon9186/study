
func isPalindrome(_ list: [String]) -> [Int] {
    var count = 0

    func recursion(_ list: [String], _ lHand: Int, _ rHand: Int) -> Int {
        count += 1
        if lHand >= rHand {
            return 1
        }

        if list[lHand] != list[rHand] {
            return 0
        }
        return recursion(list, lHand + 1, rHand - 1)
    }

    return [recursion(list, 0, list.count - 1), count]
}


let t = Int(readLine()!)!

for _ in 0..<t {
    let strList = Array(readLine()!).map { String($0) }
    let result = isPalindrome(strList)
    print(result[0], result[1])
}
