# URLSession 사용하기

### 참고
* [iOS Swift Tutorial: Working with the Web: HTTP, URL, and REST API / youtube](https://www.youtube.com/watch?v=ggEcSzPbVr4&list=PLWHegwAgjOko-_H8MPHbPJbA24Gel2fg_&index=1)

### 서두 
간단한 예제와 함께 URLSession을 활용해 get request를 보내는 법을 소개합니다. 

### index


# 사용할 API
* [Cat API](https://thecatapi.com)
* [Cat API Docs](https://developers.thecatapi.com/view-account/ylX4blBYT9FaoVd6OhvR?report=bOoHBz-8t)

랜덤하게 고양이 이미지를 가져오는 API입니다. 

# data 받아보기
기본적인 사용을 위해 웹페이지의 정보를 받아보는 예제를 만들어보겠습니다. 애플 홈페이지 정보를 받아보겠습니다.
```swift
let url = URL(string: "https:www.apple.com")!
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let data = data, let file = String(data: data, encoding: .utf8) {
        print(file)
    }
}
task.resume()
```
task.resume() 하면, dataTask로 부터 생성된 정보들이 completionHandler로 처리되는데요. 이때 핸들러는 개발자가 정의 할 수 있으니 데이터 처리, 디코딩, 에러핸들링 등을 처리 할 수 있습니다. 
data, response, error 이 3가지 파라미터는 [dataTask(with:completionHandler:) docs](https://developer.apple.com/documentation/foundation/urlsession/1410330-datatask)에서 간단히 설명을 볼 수 있는데요.   
data는 서버로 부터 받게 되는 정보, response는 response 메타데이터로 HTTP header와 state code를 가지고 있습니다. 만약 state code(200, 300번대 등등..)로 핸들링하기를 원한다면 HTTPURLResponse object로 다운케스팅 하여서 접근 할 수 있습니다. 
마지막으로 error는 request에 실패했다면 에러정보가 있고 정상적으로 처리 되었다면 nil 값을 가지고 있습니다. 
  
위 예제에서는 data를 이용해 문자열을 생성해 출력하는 예제입니다.

<img width="1143" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/e60c6e02-d945-4572-9044-47682a7c87f8">

결과는 스크립트를 출력하네요. 너무 길어서 조금만..


# 이미지 처리 
<img width="1129" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/45893383-20ec-468b-b069-73f59c1632fc">  
예제 API에서 고양이 이미지를 가져와 보겠습니다.  
UiKit에서 사용한다면 UIImage()를 생성하면 되겠죠. 정상적으로 고양이 이미지를 볼 수 있습니다. 

# JSON data 가져오기

예제로 사용할 url은 ```https://api.thecatapi.com/v1/images/search?limit=10&breed_id=abys```입니다. 
제공된 쿼리문으로 갯수제한과 종을 정해서 받아왔습니다. 

```json
[
  {"id":"xnzzM6MBI","url":"https://cdn2.thecatapi.com/images/xnzzM6MBI.jpg","width":2592,"height":1629},
  {"id":"EHG3sOpAM","url":"https://cdn2.thecatapi.com/images/EHG3sOpAM.jpg","width":1600,"height":1067},
  {"id":"KWdLHmOqc","url":"https://cdn2.thecatapi.com/images/KWdLHmOqc.jpg","width":3114,"height":2609},
  {"id":"0XYvRd7oD","url":"https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg","width":1204,"height":1445},
  {"id":"gCEFbK7in","url":"https://cdn2.thecatapi.com/images/gCEFbK7in.jpg","width":1424,"height":987},
  {"id":"Kq8__jmkT","url":"https://cdn2.thecatapi.com/images/Kq8__jmkT.jpg","width":1527,"height":1286},
  {"id":"TGuAku7fM","url":"https://cdn2.thecatapi.com/images/TGuAku7fM.jpg","width":1920,"height":1279},
  {"id":"p6x60nX6U","url":"https://cdn2.thecatapi.com/images/p6x60nX6U.jpg","width":1032,"height":774},
  {"id":"MJWtDz75E","url":"https://cdn2.thecatapi.com/images/MJWtDz75E.jpg","width":1024,"height":1024},
  {"id":"g1j3wRjgx","url":"https://cdn2.thecatapi.com/images/g1j3wRjgx.jpg","width":1024,"height":1024}
]
```

위와 같은 json data를 swift에서 사용하려고합니다. 
swift에서 사용하기위해서 json 데이터를 decode해야하고, swift 에서 사용할 수 있는 구조체(struct)로 데이터를 변환해야합니다. 
decode하기 위해서 JSONDecoder()를 사용할 수 있습니다. 
struct를 정의 하기 전달 받을 형식을 미리보고 이름을 맞춰 맵핑해야합니다. 추가적인 설정으로 이름과, 데이터 형식을 다르게 할 수도 있습니다. 
위의 예제 에서는 배열로([]) 4개의 키값을 가진 json 데이터 들이 있네요. 이를 바탕으로 구조체를 정의 해 보겠습니다.  

```swift
struct BreedImage: Codable {
    let height: Int
    let id: String
    let url: String
    let width: Int
}
```
Codable 프로토콜을 채택하여 json 데이터를 BreedImage로 변환할 수 있도록 정의해 줍니다. 

```swift
let selectedCatBreedId = "abys"
let url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10&breed_id=\(selectedCatBreedId)")!

let task = URLSession.shared.dataTask(with: url) { data, response, error in

    let jsonDecoder = JSONDecoder()
    if let data = data {
        do {
            let images = try jsonDecoder.decode([BreedImage].self, from: data)
            print("success, fetched \(images.count) image urls") // success, fetched 10 image urls
        } catch {
            print(error)
        }
    }
}

task.resume()
```
decode() 메소드가 오류를 발생할수 있는 throws를 표기하고 있어서 try 구문을 이용해 처리해 주어야 합니다. 따로 분기 처리를 위해 do-catch try로 메소드를 호출하겠습니다. 
