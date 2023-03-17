
var hakAndDeungHap: Double = 0.0
var hakHap: Double = 0.0
let dict: [String:Double] = [
    "A+" : 4.5,
    "A0" : 4.0,
    "B+" : 3.5,
    "B0" : 3.0,
    "C+" : 2.5,
    "C0" : 2.0,
    "D+" : 1.5,
    "D0" : 1.0,
    "F" : 0.0,
]

(0..<20).forEach { _ in
    let input = readLine()!.split(separator: " ")
    let (hak, deung) = (Double(input[1])!, String(input[2]))

    if deung == "P" {
        return
    }

    hakAndDeungHap += hak * dict[deung]!
    hakHap += hak
}

print(hakAndDeungHap / hakHap)
