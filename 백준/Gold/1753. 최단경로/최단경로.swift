struct Heap<T: Comparable> {
    var elements: Array<T> = []
    private let compare: (T, T) -> Bool

    init(compare: @escaping (T,T) -> Bool) {
        self.compare = compare
    }

    func isEmpty() -> Bool {
        return elements.isEmpty
    }

    func peek() -> T? {
        return elements.first
    }

    mutating func insert(_ data: T) {
        elements.append(data)
        swapUp(elements.count - 1)
    }

    mutating func delete() -> T? {
        if elements.count <= 0 {
            return nil
        }

        elements.swapAt(0, elements.count - 1)
        let returnValue = elements.popLast()
        swapDown(0)
        return returnValue
    }

    mutating private func swapUp(_ insertIndex: Int) {
        var index = insertIndex

        while index > 0 && compare(elements[index], elements[(index - 1) / 2]) {
            elements.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }

    mutating private func swapDown(_ index: Int) {
        var swapIndex = index
        let leftIndex = index * 2 + 1
        let rightIndex = index * 2 + 2
        var isSwap = false

        if leftIndex < elements.count && compare(elements[leftIndex], elements[swapIndex]) {
            isSwap = true
            swapIndex = leftIndex
        }

        if rightIndex < elements.count && compare(elements[rightIndex], elements[swapIndex]) {
            isSwap = true
            swapIndex = rightIndex
        }

        if isSwap {
            elements.swapAt(index, swapIndex)
            swapDown(swapIndex)
        }

    }

}

struct Node: Comparable {
    static func < (lhs: Node, rhs: Node) -> Bool {
        return lhs.dist < rhs.dist
    }

    let node: Int
    let dist: Int
}



let input = readLine()!.split(separator: " ").map { Int($0)! }
let (v, e) = (input[0], input[1])
// v 정점, 노드의 개수
// 1번부터
var distance = Array(repeating: Int.max, count: v + 1)

let startNode = Int(readLine()!)!

var graph = Array(repeating: Array<Node>(), count: v + 1)

for _ in 0..<e {
    let temp = readLine()!.split(separator: " ").map { Int($0)! }
    let (u, v, w) = (temp[0], temp[1], temp[2])


    graph[u].append(Node(node: v, dist: w))
}


func dijkstra(_ start: Int) {
    var pq = Heap<Node>(compare: <)
    pq.insert(Node(node: start, dist: 0))
    distance[start] = 0

    while pq.isEmpty() == false {
        let now = pq.delete()!

        if distance[now.node] < now.dist {
            continue
        }

        for next in graph[now.node] {

            let cost = distance[now.node] + next.dist

            if cost < distance[next.node] {
                pq.insert(Node(node: next.node, dist: cost))
                distance[next.node] = cost
            }
        }

    }
}

dijkstra(startNode)


print(distance[1...].map { $0 < Int.max ? String($0) : "INF" }.joined(separator: "\n"))

