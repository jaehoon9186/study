let n = Int(readLine()!)!
let aList = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
let m = Int(readLine()!)!
let search = readLine()!.split(separator: " ").map { Int($0)! }

func binarySearch(_ list: [Int], _ target: Int, _ start: Int, _ end: Int) -> Bool {

    if start > end {
        return false
    }

    let mid = (start + end) / 2

    if list[mid] == target {
        return true
    } else if list[mid] > target {
        return binarySearch(list, target, start, mid - 1)
    } else {
        return binarySearch(list, target, mid + 1, end)
    }


}
for i in search {
    print(binarySearch(aList, i, 0, n - 1) ? 1 : 0)
}
