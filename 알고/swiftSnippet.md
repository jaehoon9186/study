# 큰주제
### 소주제
내용
```swift
코드
```






# 입력
### 입력받기
```swift
let line = readLine()!
```


# 배열
### 배열초기화
```swift
var listOne: [Int] = []

//초기값이 있는 배열 초기화
var trueArray = Array(repeating: true, count: 5)
// > [true, true, true, true, true]

// 이터레이터한 숫자를 활용해 배열만들기
let numbers = Array<Int>(2...5) // [2,3,4,5]

// 2차원 배열
var board: [[Int]] = []
// board.append([Int]) 인티저배열을 append한다. 

// N*M 이차원배열 0 초기화 
var answer: [[Int]] = Array(repeating: Array(repeating: 0, count: m), count: n)

```
### 정렬
```swift
var arr = [1,3,2,4]
arr.sort() // 원본 배열 정렬
let sortedArr = arr.sorted() // 새로운 배열을 만들어 정렬후 리턴
```
### 타겟의 첫 인덱스 찾기
```swift
// arr = [1, 2, 3], target = 3
if let index = arr.firstIndex(of: target) {
    print(index)
} else {
    print(0)
}
// 마지막 인덱스는 lastIndex(of: )
```
### 배열의 포함여부 확인
```swift
// arr = [1,2,3,4] target = 2
arr.contains(target) // true
```
### 한 배열내의 값 교환하기 스왑하기
```swift
[0,1,2,3,4].swapAt(0, 4) // [4,1,2,3,0] 0번 인덱스와 4번인덱스 값 스왑
```
### 배열 일부 교체 replace
```swift
arr.replaceSubrange(i...j, with: arr[i...j].reversed())
```
### arraySlice
```swift
//  buckets = [1,2,3,4,5,6,7,8,9,10]
let slice = buckets[..<i] + buckets[k...j] + buckets[i..<k] + buckets[(j+1)...]

// 다시 배열로 쓰기 위해서
buckets = Array(slice)
```
### 배열 개수만큼 
```swift
[1,2,3,4,5].prefix(3) // [1,2,3]
[1,2,3,4,5].prefix(10) // [1,2,3,4,5] 가능한 개수만큼만 리턴해준다. 
```

# 딕셔너리 
### 딕셔너리 초기화
```swift
var tempDict: [Int: Int] = [:]
vat dict21 : Dictionary<Int, Int>()

// 초기값을 정해 업데이트 하기
tempDict[j, default: 0] += 1
```
### 딕셔너리 정렬
```swift
// 키순(오름차순)
count.sorted(by: { $0.0 < $1.0 })

// 딕셔너리[Int, Int]를 벨류, 키 순으로 내림차순 정렬
let temp = count.sorted(by: { (first, second) -> Bool in
    if first.value == second.value {
        return first.key > second.key
    }
    return first.value > second.value
} )
// 클로저 경량문법
let temp2 = count.sorted(by: {
    if $0.1 == $1.1 {
        return $0.0 > $1.0
    }
    return $0.1 > $1.1
})

// dict.sorted { ($0.value, $0.key) > ($1.value, $1.key) } // 이렇게도 가능한가
```
### key-value  에서  value-[key]로 전환하기
```swift
// 반복문활용 
기존딕셔너리.forEach {
    변환딕셔너리[$1, default: []].append($0)
}

// grouping? 활용
[링크](https://stackoverflow.com/questions/49088372/invert-keys-for-values-in-swift-dictionary-collecting-duplicate-values) 참고
```


# 반복문
### for
```swift
for i in 1...10 {
    // 반복
}
```
역순으로 반복하기
```swift
for i in (1...10).reversed() {
    // 반복
}
```
### 인덱스 까지 반복
```swift
for (index, value) in array.enumerated() {
    //
}
```
### 일정 수 단위로 증가
```swift
for i in stride(from: 시작, to: 끝, by: 몇 단위씩?) {
    // by 씩 증가하여 반복
}
```

### 딕셔너리 반복
```swift
for (key, value) in 딕셔너리 {
        // 반복
}
```

# 문자열
### 문자열 초기화
```swift
// 반복
let stirng = String(repeating: " 내용 ", count: 2) 
```
### 문자열 뒤집기
```swift
String(문자열.reversed())
```
### 문자열 분리
```swift
let string = "1 2 3"
print(string.split(separator: " "))

// Foundation 프레임워크 사용
print(string.components(separatedBy: " "))

// split()이 더 빠르다.
```
문자열을 한글자씩
```swift
// char 형식으로 배열이 생성된다. 필요하다면 캐스팅할 것
"123".map { $0 }
Array("123")
// Array() 생성자가 아닌 ["123"] 으로는 생성 불가 그냥 요소 하나 있는 배열
```
### 문자열 합치기
```swift
let arr = ["ㄱ", "ㄴ", "ㄷ", "ㄹ", "ㅁ"]
print(arr.joined(separator: "*"))
```

### 여러줄
```swift
let string = """
여러줄
문자열
"""
// 특수문자까지 출력시 #""" \ 블라블라 """#
// 개행문자 제거시 줄 끝단에 \
```

### 인덱스로 문자
```swift
// swift에서는 str[인덱스번호] 형식으로 찾는게 불가하다 왜?
// how?
str[str.index(str.startIndex, offsetBy: 3)]

// 첫, 마지막
str.first
str.last
```
### 문자열 교체
```swift
import Foundation
"aaaa".replacingOccurrences(of: "aa", with: "!") // "!!"
```

### 문자열 숫자인지 확인하기
```swift
let input = "123123"

if let number = Int(input) {
    print(number)
} else {
    print("숫자아님")
}
```


# 고차함수
### map
map을 활용해 배열 속성 변환
```swift
let stringNumbers = ["1", "2", "3", "4", "5"]
let numbers = stringNumbers.map { Int($0)! }
print(numbers) // [1, 2, 3, 4, 5]
```
### reduce
reduce를 이용해 배열 덧셈

```swift
let numbers = [1, 2, 3, 4]
let numberSum = numbers.reduce(0, { x, y in
    x + y
}) // numbers.reduce(0) { $0 + $1 }

// numberSum == 10
```

### filter
조건에 맞는 배열을 리턴. 
```swift
let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let shortNames = cast.filter { $0.count < 5 }
print(shortNames)
// Prints "["Kim", "Karl"]"
```

# 기타
### 소수점
```swift
import Foundation 

// 소수점 이하 올림
ceil(12.1)

// 소수점 이하 버림
floor(12.2)

// 소수점이하 반올림 (.5 올림, 0.4 버림)
round(10.5) // 11
round(10.4445) // 10 

// String(Format:,_arguments:)
String(format: "%.3f", 100.55555) // 100.556

// Format에 사용되는 Format Specifier ?



```


### 스왑
```swift
(a, b) = (b, a)
```

### 최대 공약수(gcd), 최소 공배수(lcm)
```swift
// 두수의 최소 공배수(lcm) == 두수의 곱 / 최대 공약수(gcd)

// 최대 공약수, 유클리드 호제법, a가 값이 커야함.
func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    }
    return gcd(b, a%b)
}

// 최소 공배수
func lcm(_ a: Int, _ b: Int) -> Int {
    return a * b / gcd(a, b)
}
```

### 소수
```swift
func isPrime(_ number: Int) -> Bool {
    if number <= 1 {
        return false
    }

    for i in 2..<Int(sqrt(Double(number))) + 1 {
        if number % i == 0 {
            return false
        }
    }

    return true
}
```

### 소수 리스트
```swift
// 구할 최대값까지 배열 선언
list[0] = false
list[1] = false

for (i, v) in list.enumerated() {
    if v {
        for j in stride(from: i + i, to: list.count, by: i) {
            list[j] = false
        }
    }
}
let primeList = list.enumerated().filter { $1 }.map { $0.offset }

```

### 제곱연산
```swift
// float or decimal
pow(_:_)
```
### 아스키 코드 변환
```swift
// String to Ascii
let ch = "C"
let asciiIntValue_C = Int(UnicodeScalar(ch)!.value)
let asciiIntValue_A = Int(UnicodeScalar("A").value)	 // 0x41, 65(d)

// Ascii Int Value to String
let result = String(UnicodeScalar(asciiIntValue_A)!)

String(UnicodeScalar(97)) //a
Char(UnicodeScalar(97)) //a

```

### 진수변환
```swift
https://developer.apple.com/documentation/swift/int/init(_:radix:)
참고

```

### 데시멀 to Int
```swift
(pow(2, 15) as NSDecimalNumber).intValue
```

### 2차원 배열 특정영역 합 / 슬라이딩 윈도우 
2차원 배열이 주어질때 좌상단 부터 단계별로 합을 입력해 놓은 배열을 만들고 


### 순열
```swift
// 순열 : n개 중 r개 순서신경써서 뽑기
// DFS, 체크리스트 이용
//let strArray = ["a", "b", "c"]
//var visited = Array(repeating: false, count: strArray.count)
func perm(_ arr: [String], _ r: Int, _ visited: inout [Bool], _ output: [String] = []) {
    // 초기화
    var output = output
    // 종료 조건
    if output.count == r {
        print(output)
        return
    }
    // 반복 문, 재귀
    for i in 0..<arr.count {
        if !visited[i] {
            visited[i] = true
            output.append(arr[i])
            perm(arr, r, &visited, output)
            output.removeLast()
            visited[i] = false
        }
    }
}

// DFS, 스왑
// arr, r, dept
//var strArray = ["a", "b", "c"]
//permSwap(&strArray, strArray.count)
func permSwap(_ arr: inout [String], _ r: Int, _ dept: Int = 0) {
    if dept == r {
        print(arr)
        return
    }

    for i in dept..<arr.count {
        arr.swapAt(dept, i)
        permSwap(&arr, r, dept + 1)
        arr.swapAt(dept, i)
    }

}

// DFS, left, right
//var strArray = ["a", "b", "c"]
//permLeftRight(strArray, 3)
func permLeftRight(_ arr: [String], _ r: Int, _ output: [String] = []) {
    if output.count == r {
        print(output)
        return
    }

    for i in 0..<arr.count {
        permLeftRight(Array(arr[0..<i] + arr[(i+1)...]), r, output + Array(arrayLiteral: arr[i]))
    }

}


```

### 조합
```swift
// 조합 : n개 중 r개 순서 상관 없이 뽑기
//let strArray = ["a", "b", "c"]
//comb(strArray, 2)
func comb(_ arr: [String], _ r: Int, _ dept: Int = 0, _ output: [String] = []) {
    var output = output

    if output.count == r {
        print(output)
        return
    }

    for i in dept..<arr.count {
        output.append(arr[i])
        comb(arr, r, i + 1, output)
        output.removeLast()
    }
}

// 조합 결과를 리턴 받기
func getCombResult(_ arr: [Int], _ r: Int) -> [[Int]] {
    var result: [[Int]] = []

    func comb(_ arr: [Int], _ r: Int, _ dept: Int = 0, _ output: [Int] = []) {
        // comb 재귀
    }

    comb(arr, r)

    return result
}
```

### 조합 개수 구하기
```swift
// 조합의 성질을 이용해 재귀로 구현
// nCr == n-1Cn-r  +  n-1Cr
func combCount(_ n: Int, _ r: Int) -> Int {
    if n == r || r == 0 {
        return 1
    }

    return combCount(n - 1, r - 1) + combCount(n - 1, r)
}

for _ in 0..<time {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (r, n) = (input[0], input[1])

    print(combCount(n, r))

}
```
```swift
var combCountArr: [[Int]] = Array(repeating: Array(repeating: 0, count: 31), count: 31)
// n의 최대값 30 까지 조합의 개수들 구해놓기
for n in 0..<31 {
    for r in 0...n {
        if n == r || r == 0 {
            combCountArr[n][r] = 1
            continue
        }

        combCountArr[n][r] = combCountArr[n - 1][r - 1] + combCountArr[n - 1][r]
    }
}
```

### 조건에 맞는 배열의 인덱스만 배열로 만들기 
```swift
let arr = 배열.indices.filter { 조건 }
```


### 팩토리얼
```swift
func factorial(_ num: Int) -> Int {
    if num < 2 {
        return 1
    }

    return factorial(num - 1) * num
}
```

### 큐 queue 
```swift
struct Queue {
    private var queue: [Int?] = []
    private var head: Int = 0

    public var isEmpty: Bool {
        return size == 0
    }

    public var size: Int {
        return queue.count - head
    }

    public mutating func push(_ element: Int) {
        queue.append(element)
    }

    public mutating func pop() -> Int? {
        guard isEmpty == false, let element = queue[head] else {
            return -1
        }

        head += 1
        // 일정 queue길이가 되면 초기화해주는 과정도 필요함.

        return element
    }

    public func front() -> Int? {
        return isEmpty ? -1 : queue[head]
    }

    public func back() -> Int? {
        return isEmpty ? -1 : queue[queue.endIndex - 1]
    }
}
```
