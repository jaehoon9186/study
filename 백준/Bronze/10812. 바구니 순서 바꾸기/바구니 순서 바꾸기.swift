let input = readLine()!.split(separator: " ").map { Int($0)! }
let (bucketCount, time) = (input[0], input[1])

var buckets = Array<Int>(1...bucketCount)

(0..<time).forEach { _ in
    let input2 = readLine()!.split(separator: " ").map { Int($0)! }
    let (i, j, k) = (input2[0] - 1, input2[1] - 1, input2[2] - 1)


    let slice = buckets[..<i] + buckets[k...j] + buckets[i..<k] + buckets[(j+1)...]

    buckets = Array(slice)

}

print(buckets.map { String($0) }.joined(separator: " "))
