import Foundation

func cantor(_ list: inout [String], _ i: Int, _ j: Int, _ k: Int, _ r: Int) {
    if r - i < 2 {
        return
    }

    cantor(&list, i, i + ((j - i) * 1 / 3), i + ((j - i) * 2 / 3), j)
    cantor(&list, k, k + ((r - k) * 1 / 3), k + ((r - k) * 2 / 3), r)

    for idx in j..<k {
        list[idx] = " "
    }
}

while let n = readLine() {
    var list = Array(repeating: "-", count: Int(pow(3.0, Double(n)!)))
    let count = list.count
    cantor(&list, 0, 0 + ((count - 0) * 1 / 3), 0 + ((count - 0) * 2 / 3), count)

    print(list.joined())
}



