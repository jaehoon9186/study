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

// 2차원 배열
var board: [[Int]] = []
// board.append([Int]) 인티저배열을 append한다. 

```

# 딕셔너리 
### 딕셔너리 초기화
```swift
var tempDict: [Int: Int] = [:]

// 초기값을 정해 업데이트 하기
tempDict[j, default: 0] += 1
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
### 문자열 뒤집기
```swift
String(문자열.reversed())
```

# 함수

# 기타
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
