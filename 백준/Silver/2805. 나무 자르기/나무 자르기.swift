let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])

let trees = readLine()!.split(separator: " ").map { Int($0)! }.sorted(by: >)



func binarySearch(_ list: [Int], _ target: Int) {
    var (left, right) = (0, list[0])

    while left <= right {
        let mid = (left + right) / 2
        var cutSum = 0
        for i in list {
            if mid < i {
                cutSum += i - mid
            }
        }

        if cutSum < target {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }

    print(right)

}

binarySearch(trees, m)

