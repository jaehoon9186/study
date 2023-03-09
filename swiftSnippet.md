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

### 제곱연산
```swift
// float or decimal
pow(_:_)
```
