let t = Int(readLine()!)!
var star = ""

for i in 1...t {
    star += "*"
    print("\(String(repeating: " ", count: t-i))\(star)")
}
