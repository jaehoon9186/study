let input = readLine()!.split(separator: " ").map { Int($0)! }
let (n, k) = (input[0], input[1])
var arr = readLine()!.split(separator: " ").map { Int($0)! }
var temp = Array(repeating: -1, count: n)
var count = 0
var answer = -1


func mergeSort(_ arr: inout [Int], _ p: Int, _ r: Int) {
    if p < r {
        let q = (p + r) / 2
        mergeSort(&arr, p, q)
        mergeSort(&arr, q + 1, r)
        merge(&arr, p, q, r)
    }
}

func merge(_ arr: inout [Int], _ p: Int, _ q: Int, _ r: Int) {
    var i = p
    var j = q + 1
    var t = 0

    while i <= q && j <= r {
        if arr[i] <= arr[j] {
            temp[t] = arr[i]
            i += 1
            t += 1
        } else {
            temp[t] = arr[j]
            j += 1
            t += 1
        }
    }

    while i <= q {
        temp[t] = arr[i]
        i += 1
        t += 1
    }

    while j <= r {
        temp[t] = arr[j]
        j += 1
        t += 1
    }

    i = p
    t = 0
    while i <= r {
        count += 1
        if count == k {
            answer = temp[t]
            break
        }

        arr[i] = temp[t]
        i += 1
        t += 1
    }
}

mergeSort(&arr, 0, arr.count - 1)
print(answer)
