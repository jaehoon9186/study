let input = readLine()!.split(separator: " ").map { Int($0)! }
let (k, n) = (input[0], input[1])
var lenList: [Int] = []
var result = 0


for _ in 0..<k {
    lenList.append(Int(readLine()!)!)
}

lenList.sort()

func foundlenth(_ start: Int, _ end: Int, _ list: [Int], _ n: Int) {
    if end - start <= 1 {
        print(start)
        return
    }

    let mid = (start + end) / 2
    var count = 0
    for i in list {
        count += i / mid
    }

    if count < n {
        foundlenth(start, mid, list, n)
    } else {
        foundlenth(mid, end, list, n)
    }

}

foundlenth(1, lenList.last! + 1, lenList, n)
