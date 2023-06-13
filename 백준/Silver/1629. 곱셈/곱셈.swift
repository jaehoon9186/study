
let input = readLine()!.split(separator: " ").map { Int($0)! }
let (a, b, c) = (input[0], input[1], input[2])
var result = 1

func dfs(_ num: Int, _ n: Int) -> Int {
    if n == 0 {
        return 1
    }

    if n % 2 == 0 {
        let temp = dfs(num, n / 2)
        return temp % c * temp % c
    }else {
        let temp = dfs(num, n / 2)
        return temp % c * temp % c * num % c
    }
}


print(dfs(a, b))
