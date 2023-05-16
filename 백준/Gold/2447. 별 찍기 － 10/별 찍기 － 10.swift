let n = Int(readLine()!)!

var list: [[String]] = Array(repeating: Array(repeating: "*", count: n), count: n)

func recursionStar(_ star: inout [[String]], _ start: (Int, Int), _ end: (Int, Int)) {

    if end.0 - start.0 < 2 {
        return
    }


    let diff = (end.0 - start.0) / 3
    let startIdxListI = Array(stride(from: start.0, to: end.0, by: diff))
    let startIdxListJ = Array(stride(from: start.1, to: end.1, by: diff))
    var count = 0

    for i in startIdxListI {
        for j in startIdxListJ {
            count += 1
            if count == 5 {
                deleteStar(&star, (i, j), (i + diff, j + diff))
                continue
            }
            recursionStar(&star, (i, j), (i + diff, j + diff))
        }
    }
}

func deleteStar(_ star: inout [[String]], _ start: (Int, Int), _ end: (Int, Int)) {
    for i in start.0..<end.0 {
        for j in start.1..<end.1 {
            star[i][j] = " "
        }
    }
}


recursionStar(&list, (0,0), (n, n))

for i in list {
    print(i.joined())
}
