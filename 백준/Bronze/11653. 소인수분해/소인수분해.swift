var n = Int(readLine()!)!
var i = 2

func soinsu(number: Int) {
    if n == 1 {
        return
    }

    while n > 1 {
        if n % i == 0 {
            print(i)
            n = n / i
            continue
        }
        i += 1
    }
}

soinsu(number: n)
