import Foundation

func solution(_ N:Int, _ road:[[Int]], _ k:Int) -> Int {
    
    var nodeList: [Int: [(Int, Int)]] = [:]
    var distance: [Int] = Array(repeating: Int.max, count: N)
    distance[0] = 0
    var visited: [Bool] = Array(repeating: false, count: N)
    
    var pq = MinHeap()
    pq.insert(0, distance[0])
    
    for i in road {
        let (from, to, d) = (i[0] - 1, i[1] - 1, i[2])
        nodeList[from, default: []].append((to, d))
        nodeList[to, default: []].append((from, d))
    }
    
    while pq.isEmpty() == false {
        guard let temp = pq.delete() else { break }
        let (from, value) = (temp.0, temp.1)
        
        if visited[from] {
            continue
        }
        visited[from] = true
        
        guard let toList = nodeList[from] else { break }
        for i in toList {
            let (to, d) = (i.0, i.1)
            
            if distance[to] > distance[from] + d {
                distance[to] = distance[from] + d
                pq.insert(to, distance[to])
            }
        }
    }
    
    return distance.filter { $0 <= k }.count
}

struct MinHeap {
    var elements: [(Int, Int)] = []
    
    func isEmpty() -> Bool {
        return elements.isEmpty
    }
    
    mutating func insert(_ key: Int, _ value: Int) {
        elements.append((key, value))
        swapUp(elements.count - 1)
    }
    
    mutating private func swapUp(_ index: Int) {
        var index = index
        while index > 0 && elements[(index - 1) / 2].1 > elements[index].1 {
            elements.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }
    
    mutating func delete() -> (Int, Int)? {
        if elements.count <= 0 {
            return nil
        }
        
        let pop = elements.first
        elements.swapAt(0, elements.count - 1)
        elements.removeLast()
        
        swapDown(0)

        return pop
        
    }
    
    mutating private func swapDown(_ index: Int) {
        var isSwap = false
        let leftIndex = index * 2 + 1
        let rightIndex = index * 2 + 2
        var swapIndex = index
        
        if leftIndex < elements.count && elements[leftIndex].1 < elements[swapIndex].1 {
            isSwap = true
            swapIndex = leftIndex
        }
        
        if rightIndex < elements.count && elements[rightIndex].1 < elements[swapIndex].1 {
            isSwap = true
            swapIndex = rightIndex
        }
        
        if isSwap {
            elements.swapAt(index, swapIndex)
            swapDown(swapIndex)
        }
    }
}