func solution(_ n:Int, _ t:Int, _ m:Int, _ p:Int) -> String {
    
    var temp: [String] = []
    
    var i = 0
    while temp.count <= t * m {
        temp += String(i, radix: n).map { String($0) }
        i += 1
    }
    
    return temp.flatMap { $0 }.enumerated().filter { $0.offset % m == (p - 1) }.map { $0.element.uppercased() }[0..<t].joined()
}