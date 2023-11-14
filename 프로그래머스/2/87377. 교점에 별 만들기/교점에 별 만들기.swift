import Foundation

struct Pos: Hashable {
    var y: Int
    var x: Int
}

func solution(_ line:[[Int]]) -> [String] {
    
    var setPosition = Set<Pos>()
    
    var minY = Int.max
    var maxY = Int.min
    var minX = Int.max
    var maxX = Int.min
    
    for i in 0..<line.count {
        for j in 0..<line.count {
            let (a, b, e) = (line[i][0], line[i][1], line[i][2])
            let (c, d, f) = (line[j][0], line[j][1], line[j][2])
            
            let mo = a * d - b * c
            if mo == 0 { continue }
            
            var x = Double(b*f - e*d) / Double(mo)
            var y = Double(e*c - a*f) / Double(mo)
        
            if x != x.rounded() || y != y.rounded() {
                continue
            }
            
            let intX = Int(x)
            let intY = Int(y)
            
            minY = min(minY, intY)
            maxY = max(maxY, intY)
            minX = min(minX, intX)
            maxX = max(maxX, intX)
            
            setPosition.insert(Pos(y: intY, x: intX))
        }
    }
    
    let diffY = minY * -1
    let diffX = minX * -1
    
    var result: [[String]] = Array(repeating: Array(repeating: ".", count: maxX + diffX + 1), count: maxY + diffY + 1)
    
    for i in setPosition {
        result[i.y + diffY][i.x + diffX] = "*"
    }
    
    
    return result.reversed().map { $0.joined() }
}