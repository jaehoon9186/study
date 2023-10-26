func solution(_ m:Int, _ n:Int, _ board:[String]) -> Int {
    
    var b: [[String]] = []
    var bCopy: [[String]] = []
    var isChanged: Bool = true
    
    for i in 0..<board.count {
        b.append(board[i].map { String($0) })
    }
    bCopy = b
    
    while isChanged {

        isChanged = false
        for i in 0..<(m - 1) {
            for j in 0..<(n - 1) {
                let check = b[i][j]

                if check != "*" && b[i][j] == b[i + 1][j] && b[i][j] == b[i][j + 1] && b[i][j] == b[i + 1][j + 1] {
                    bCopy[i][j] = "*"
                    bCopy[i + 1][j] = "*" 
                    bCopy[i][j + 1] = "*"
                    bCopy[i + 1][j + 1] = "*" 
                    isChanged = true
                } 
            }
        }
        
        for i in (1..<m).reversed() {
            for j in (0..<n).reversed() {
                if bCopy[i][j] != "*" {
                    continue
                }

                for k in (0..<i).reversed() {
                    if bCopy[k][j] != "*" {
                        bCopy[i][j] = bCopy[k][j]
                        bCopy[k][j] = "*"
                        break
                    }
                }
            }
        }

        b = bCopy
    }
    
    
    return b.flatMap{ $0 }.filter { $0 == "*" }.count
}