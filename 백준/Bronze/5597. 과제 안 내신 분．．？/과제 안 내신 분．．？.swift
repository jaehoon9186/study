var students = Dictionary<Int,Int>()

(1...30).forEach{
    students[$0] = 0
}

(1...28).forEach{ _ in
    students[Int(readLine()!)!] = 1
}

students.filter { $1 == 0 }.map { $0.0 }.sorted(by: <).forEach {
    print($0)
}
