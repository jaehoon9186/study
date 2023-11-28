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


# 예제 

뷰컨트롤러에서 API를 호출하여 데이터를 받는 형식으로 진행하겠습니다. 

### 사용할 api
url : https://suggestqueries.google.com/complete/search?output=toolbar&hl=kor&q=coffee  
구글 정식 API는 아니나 사용자들이 발견한 API라고 합니다. q="" 입력된 문자(검색어)를 기반으로 추천하는 검색어를 XML을 반환합니다.  
+ hl=kor : 국적 기반 추천


공식 API Documentation을 찾지 못함.. [스택오버플로우 참고](https://stackoverflow.com/questions/5102878/where-is-the-documentation-for-the-google-suggest-api)
많이 호출하면 차단된다는데. 기준을 모르겠으니 조심..
 
### ViewController
```swift
import UIKit

class ViewController: UIViewController {

    private var items: [Suggestion]?

    override func viewDidLoad() {
        super.viewDidLoad()
        fatchData()
    }

    func fatchData() {
        let parser = SuggestionParser()

        let url = "https://suggestqueries.google.com/complete/search?output=toolbar&hl=kor&q=커피"
        let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        parser.parseFeed(url: encodedUrl) { (suggestionItems) in

            print(suggestionItems)
            self.items = suggestionItems
        }
    }
}
```
### Model
```swift
struct Suggestion {
    let word: String
}
```

### XMLParser
```swift
import Foundation

// XMLParserDelegate 채택,
// XMLParserDelegate를 채택하려면 NSObject를 상속받아야 합니다. 
class SuggestionParser: NSObject, XMLParserDelegate {
    private var suggestionItems: [Suggestion] = []
    private var currentElement = ""
    private var currentWord = ""

    private var parserCompletionHandler: (([Suggestion]) -> Void)?

    func parseFeed(url: String, completionHandler: (([Suggestion]) -> Void)?) {
        self.parserCompletionHandler = completionHandler

        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print("???")
                    print(error.localizedDescription)
                }
                return
            }

            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }

        task.resume()
    }

    // MARK: - XML Parser Delegate
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {

        if elementName == "suggestion" {
            suggestionItems.append(Suggestion(word: attributeDict["data"]!))
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(suggestionItems)
    }

    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}

```

### 결과 
출력된 결과
```swift
[SearchApp.Suggestion(word: "커피"), SearchApp.Suggestion(word: "커피머신"), SearchApp.Suggestion(word: "커피집"), SearchApp.Suggestion(word: "커피갤러리"), SearchApp.Suggestion(word: "커피빈"), SearchApp.Suggestion(word: "커피 리브레"), SearchApp.Suggestion(word: "커피챗"), SearchApp.Suggestion(word: "커피냅"), SearchApp.Suggestion(word: "커피 포트"), SearchApp.Suggestion(word: "커피 종류")]
```
