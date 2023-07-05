let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, m) = (input[0], input[1])

var houses: [Int] = []
var answer = Int.min

(0..<n).forEach { _ in
    houses.append(Int(readLine()!)!)
}
houses.sort()


func binarySearch(_ left: Int, _ right: Int) {
    if left > right {
        print(answer)
        return
    }

    let mid = (left + right) / 2
    var count = 0
    var tempHouse = 0

    for i in houses.indices {
        if i == 0 {
            count += 1
            tempHouse = houses[i]
            continue
        }

        if houses[i] >= tempHouse + mid {
            count += 1
            tempHouse = houses[i]
        }
    }

    if count < m {
        binarySearch(left, mid - 1)
    } else {
        answer = max(answer, mid)
        binarySearch(mid + 1, right)
    }
}

binarySearch(1, houses[n - 1] - houses[0])
