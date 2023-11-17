import Foundation

func solution(_ jobs:[[Int]]) -> Int {
    
    var processQueue: [[Int]] = []
    
    var sortedJobs = jobs.sorted { $0[0] < $1[0] } 
    
    var endMs = 0
    var processMs = 0
    
    
    while sortedJobs.isEmpty == false || processQueue.isEmpty == false {

        while let first = sortedJobs.first, processQueue.isEmpty, endMs < first[0] {
            endMs += 1
        }
        
        while let first = sortedJobs.first, endMs >= first[0] {
            processQueue.append(first)
            sortedJobs.removeFirst()
        }
        
        
        processQueue = processQueue.sorted { 
            if $0[1] == $1[1] {
                return $0[0] < $1[0]
            }
            return $0[1] < $1[1] 
        }
        
        let temp = processQueue.removeFirst()
        let (request, processing) = (temp[0], temp[1])

        processMs += (endMs - request + processing)
        endMs += processing
    }
    
    return processMs / jobs.count
}