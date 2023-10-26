func solution(_ cacheSize:Int, _ cities:[String]) -> Int {
    
    var time = 0
    var cacheList: [String] = []
    
    for i in cities {
        var city = i.lowercased()
        
        // hit
        if cacheList.contains(city) {
            if let index = cacheList.firstIndex(of: city) {
                cacheList.remove(at: index)
                cacheList.append(city)
            }
            time += 1
            continue
        } 
        
        // miss
        cacheList.append(city)
        if cacheList.count > cacheSize {
            cacheList.removeFirst()
        } 
        time += 5
    }
    
    return time
}