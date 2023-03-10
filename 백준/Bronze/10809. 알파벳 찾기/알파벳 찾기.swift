let word = readLine()!
var alpha: [Character:Int] = [:]
let wordStartIdx = word.startIndex

// 딕셔너리 초기화
(Character("a").asciiValue!...Character("z").asciiValue!).forEach {
    alpha[Character(UnicodeScalar($0))] = -1
}

// 단어 개수만큼 반복하며 딕셔너리 업데이트
// 중복을 피하기 위해 역순으로 처리
(0..<word.count).reversed().forEach {
    let char = word[word.index(wordStartIdx, offsetBy: $0)]
    alpha[char] = $0
}

// 딕셔너리 키(알파벳) 순서로 -> 배열 -> 문자열
print(alpha.sorted { $0.key < $1.key }.map { String($0.value) }.joined(separator: " ") )
