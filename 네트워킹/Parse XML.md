# Parse XML

XML 파일을 swift에서 사용할 수 있도록 parse해보겠습니다.  
많은 api가 JSON형식인데, 아직 xml형식도 있는것 같아 정리하려고 합니다.   

### 참고 
* [youtube 영상](https://www.youtube.com/watch?v=fP69LI5bZlg)
* [apple documentation](https://developer.apple.com/documentation/foundation/xmlparser)

### 유용
* []()

# 흐름
1. get request
2. dataTask로 생성된 data로 XMLParser() 생성, delegate 대리자 지정, parse()메서드 실행
3. delegate 메서드 순차 실행하며 반환할 변수 업데이트. 
4. callback 형식으로 반환.

# XMLParser 
```swift
let request = URLRequest(url: URL(string: url)!)
let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
    guard let data = data else {
        if let error = error {
            print(error.localizedDescription)
        }
        return
    }

    let parser = XMLParser(data: data)
    parser.delegate = self
    parser.parse()
}
task.resume()
```
data로 XMLParser를 생성하고 parse()메서드를 실행하여 파싱을 진행합니다.   
delegate를 self로 지정합니다. 

# XMLParserdelegate
[XMLParserdelegate docs](https://developer.apple.com/documentation/foundation/xmlparserdelegate) 참고  
기본적으로 사용할 delegate 메서드는 다음과 같습니다. 
* func parser(XMLParser, didStartElement: String, namespaceURI: String?, qualifiedName: String?, attributes: [String : String]) : 시작 태그 발견
* func parser(XMLParser, didEndElement: String, namespaceURI: String?, qualifiedName: String?) : 종료 태그 발견
* func parser(XMLParser, foundCharacters: String) : 현재 요소(태그)의 문자열이 존재할 때
* func parserDidEndDocument(XMLParser) : 전체 xml 분석이 성공적으로 끝났을 때
* func parser(XMLParser, parseErrorOccurred: Error) : 에러 발견시

```xml
<!-- xml 시작 -->
<toplevel data="속성있음"> <!-- 시작 태그 발견 --> <!-- 속성이 있을때, attributes 딕셔너리로 키값으로 가져오자.  -->
  <CompleteSuggestion> <!-- 시작 태그 발견 -->
    <subElement1> <!-- 시작 태그 발견 -->
        문자열1 <!-- 문자열 -->
    </subElement1> <!-- 종료 태그 발견 -->
    <subElement2> <!-- 시작 태그 발견 -->
        문자열2 <!-- 문자열 -->
    </subElement2> <!-- 종료 태그 발견 -->
  </CompleteSuggestion> <!-- 종료 태그 발견 -->
  <CompleteSuggestion> 
    <!-- 위와 같음 -->
  </CompleteSuggestion>
</toplevel>
<!-- xml 분석 끝 -->
```
```swift
private var suggestionItems: [Suggestion] = []
private var currentElement = ""
private var currentSubElement1 = ""
private var currentSubElement2 = ""

func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    // 매 시작태그마다 클래스 맴버 변수인 currentElement를 업데이트
    currentElement = elementName

    // 현재 태그가 구분이 될 "CompleteSuggestion" 면 초기화
    if currentElement == "CompleteSuggestion" {
        currentSubElement1 = ""
        currentSubElement2 = ""
    }
}

func parser(_ parser: XMLParser, foundCharacters string: String) {
    // currentElement 기준으로 이하 속성 업데이트
    switch currentElement {
    case "subElement1":
        currentSubElement1 = string
    case "subElement2":
        currentSubElement2 = string
    default:
        return
    }
}

func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    // 종료 태그 확인, 정의한 배열에 추가
    if currentElement == "CompleteSuggestion" {
        suggestionItems.append(Suggestion(sub1: currentSubElement1, sub2: currentSubElement2))
    }
}  
```
이렇게 델리게이트 메서드들이 순차적으로 반복되며 실행이 되고 분기처리를 하여 반환할 변수(suggestionItems)를 업데이트하면 됩니다. 


