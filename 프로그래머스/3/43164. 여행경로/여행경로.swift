import Foundation

func solution(_ tickets:[[String]]) -> [String] {
    
    var visited = Array(repeating: false, count: tickets.count)
    var result: [String] = []
    
    func air(_ index: Int, _ output: [String]) {
        var output = output
        
        if output.count >= tickets.count + 1 {
            if result.isEmpty {
                result = output
                return
            } 
            
            for i in zip(result, output) {
                if i.0 == i.1 { continue }
                if i.0 > i.1 { result = output }
                break
            }
            return
        }
        
        for i in 0..<tickets.count {
            if visited[i] == false && tickets[index][1] == tickets[i][0] {
                visited[i] = true
                output.append(tickets[i][1])
                air(i, output)
                output.removeLast()
                visited[i] = false
            }
        }
    }
    
    for i in 0..<tickets.count {
        if tickets[i][0] == "ICN" {
            visited[i] = true
            air(i, tickets[i])
            visited[i] = false
        }
    }
    
    
    return result
}
