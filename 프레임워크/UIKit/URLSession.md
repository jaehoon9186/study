## Document
[Fetching Website Data into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory).   
[URLSession](https://developer.apple.com/documentation/foundation/urlsession)

[참고 블로그 1](https://hcn1519.github.io/articles/2017-07/iOS_URLSession).  
[참고 블로그 2](https://kirkim.github.io/swift/2022/08/13/urlsession.html).  
[3](https://leechamin.tistory.com/554).  
[4](https://yoonah-dev.oopy.io/a187c843-11d1-4d53-8359-b1ec593a1729).  

## URLSession 순서
1. URL 설정
2. URLSession 생성  
3. Task 만들기  
4. 네트워크 네트워크 요청완료 핸들러처리

### 1. URL or Request 설정. 
```swift
let url = URL(string: "www.naver.com/")!
// 주소에 문제 가 있을 수 있으니 guard let으로 에러 처리를 해보는 것도 좋을 듯하다. 
// 도큐먼트에는 단순히 옵셔널 언래핑했음.
// 단순히 GET만 하는경우 충분
```
```swift
let url = URL(string: "www.naver.com/")!
let request = URLRequest(url: url) // default httpMethod = "GET"
/*
GET이외에 POST .. 등등의 요청이 필요한 경우 
request 인스턴스를 만들고 다양한 옵션들을 수정하여 사용하자. 
request.httpMethod = "POST" 요청방식을 수정한다거나
request.allHTTPHeaderFields = ["authorization":"token "] 해더필드를 
request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)

*/


```

### 2. URLSession 설정
Shared or URLSession 생성  
내가 필요한 기능에 맞춰 세션을 생성하자. 
```swift
let shared = URLSession.shared
```
```swift
let session = URLSession(configuration: .default)
```

> URLSession ?<br>
```
문서 한줄 설명 : An object that coordinates a group of related, network data transfer tasks.  

개요 :
url로 표시괸 endPoint에서 데이터를 다운로드 업로드 하기 위한 API를 제공.
background 다운도 지원한다. 
각종 델리게이트를 사용하여 인증, 다양한 이벤트 수신 등 가능. 

여러개의 URLSession인스턴스를 하나의 앱에 만드는 것도 가능하지만 유사하게 구성된 Session이라면 하나로 만들어 공유하는것을 권장. 

```

> Shared Session, URLSession 차이
```
1. Shared
Shared Session은 URLSession 클래스에서 사용자가 간단하게 사용할 수 있도록 제공하는 싱글톤 세션 오브젝트임.
기본적인 기능은 사용가능하나. 몇가지의 제한이 있다.

- You can’t obtain data incrementally as it arrives from the server.
- You can’t significantly customize the default connection behavior.
- Your ability to perform authentication is limited.
- You can’t perform background downloads or uploads when your app isn’t running.

2. URLSession
URLSession은 3가지 종류가 존재함. 

- `default`
A default session configuration object.

- ephemeral
A session configuration that uses no persistent storage for caches, cookies, or credentials.

- background(withIdentifier: String)
Creates a session configuration object that allows HTTP and HTTPS uploads or downloads to be performed in the background.

```


### 3. Task 만들기

```swift
let task = shared.dataTask(with: <#url or request#>) {data, response, error in
    /*
      Receive Results with a Completion Handler
    */
}
task.resume()
```

> Task 종류
```
URLSessionTask
: A task, like downloading a specific resource, performed in a URL session.

Use URLSession’s dataTask(with:) and related methods to create URLSessionDataTask instances. 
Data tasks request a resource, returning the server’s response as one or more NSData objects in memory. 
They are supported in default, ephemeral, and shared sessions, but are not supported in background sessions.

Use URLSession’s uploadTask(with:from:) and related methods to create URLSessionUploadTask instances. 
Upload tasks are like data tasks, except that they make it easier to provide a request body 
so you can upload data before retrieving the server’s response. Additionally, upload tasks are supported 
in background sessions.

Use URLSession’s downloadTask(with:) and related methods to create URLSessionDownloadTask instances. 
Download tasks download a resource directly to a file on disk. Download tasks are supported in any type of session.

Use URLSession’s streamTask(withHostName:port:) or streamTask(with:) to create URLSessionStreamTask instances. 
Stream tasks establish a TCP/IP connection from a host name and port or a net service object.
```


### 4. 네트워크 네트워크 요청완료 / 핸들러처리 / DataTask()

![image](https://github.com/jaehoon9186/study/assets/83233720/a0e49812-cd49-4a7a-9f87-7cca0d1fd247)  

```
To create a data task that uses a completion handler, call the dataTask(with:) method of URLSession. 
Your completion handler needs to do three things:

1. Verify that the error parameter is nil. If not, a transport error has occurred; handle the error and exit.

2. Check the response parameter to verify that the status code indicates success and that the MIME type is an expected value. If not, handle the server error and exit.

3. Use the data instance as needed.
```
  
```swift
func startLoad() {
    let url = URL(string: "https://www.example.com/")!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // 1. 에러 검증
        // handleClientError() 함수를 만들지 않아서 print(error.localizedDescription)으로 테스트해본다. 
        if let error = error {
            self.handleClientError(error)
            return
        }
        
        // 2. response status code 검증
        // 200 번대 : 정상, 다른 번호로 response가 오는 경우에 따른 분기 처리도 가능할 듯.
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            self.handleServerError(response)
            return
        }
        
        // 3. data 검증 및 사용 
        if let mimeType = httpResponse.mimeType, mimeType == "text/html",
            let data = data,
            let string = String(data: data, encoding: .utf8) {
            DispatchQueue.main.async {
                self.webView.loadHTMLString(string, baseURL: url)
            }
        }
    }
    task.resume()
}
```
> mineType?
```
추후 작성 예정. 

response 데이터의 타입을 명시
문서, 파일, 바이트 모음의 형식 
"application/json", "text/html" 등. 

```


> 인코딩, 디코딩, codable?  
[codable](https://developer.apple.com/documentation/swift/codable)
```
인코딩 : 스위프트 인스턴스를 다른 데이터 형태로 변환
디코딩 : 다른 테이터 형태를 스위프트 인스턴스로 변환


- Encodable :
- Decodable :
- Codable : Encodable & Decodable
json 을 변환하기 위해서 위의 프로토콜을 채택하는 인스턴스를 만들어 Data를 받아보자. 
```
```
* 디코딩 방법
1. 디코딩할 타입 정의 
구조체에 Decodable or Codable 프로토콜 체택

2. json data 전달 
JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)

3. 결과 사용. 
```
```swift
// 0. json data
let jsonData =
"""
{
"species" : "cat",
"name" : "nabi",
"age" : 1
}
"""
let data = jsonData.data(using: .utf8)

// 1
struct Animal: Codable {
    var species: String
    var name: String
    var age: Int
}

// 2
let decoder = JSONDecoder()

if let data = data,
    let result = try? decoder.decode(Animal.self, from: data) {
    // 3
    print(result.name)
} else {
    print("not work")
}
```

```swift
// UIImage 가져오기 
// 이미지를 세팅하는 과정은 main thread에서 진행해야한다. 
// 동기로 가져오기때문에 주의, 비동기로는 어떻게?
func getImage(from string: String) -> UIImage? {
    guard let url = URL(string: string) else {
        return nil
    }

    var image: UIImage?

    do {
        let data = try Data(contentsOf: url, options: [])
        image = UIImage(data: data)
    } catch {
        print(error.localizedDescription)
    }

    return image
}
```


> 에러 핸들링
```
```


### 4-1. 더많은 기능을 원한다면 핸들러 처리보단, Delegate 패턴으로 
![image](https://github.com/jaehoon9186/study/assets/83233720/e52f5583-0960-4f05-82b1-6f98c280e8d3)
```

```

## NetworkManager Code
















