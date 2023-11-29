# URLSession 사용하기2.md

간단한 API로 사용하는 예제를 알아보겠습니다. 

### API 정보
* [jsonplaceholder API](https://jsonplaceholder.typicode.com/)
* [JSONSerialization Docs](https://developer.apple.com/documentation/foundation/jsonserialization)


# POST
<img width="993" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/27e040cc-8a4f-4cca-90f0-a2dc4307d5b5">

```swift
func postTest() {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    var request = URLRequest(url: url)

    // MARK: - method, body, headers
    request.httpMethod = "POST"
    request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
    let body: [String: AnyHashable] = [
        "userId": 1,
        "title": "foo",
        "body": "bar"
    ]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    // JSONSerialization 의 data()메서드를 이용해 json으로 변환해 줍니다. 옵션도 알아볼 것. 

    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else { return }

        do {
            let response = try JSONSerialization.jsonObject(with: data)
            // jSONDecoder를 이용, response를 매핑할꺼면
            print(response)
        } catch {
            print(error)
        }
    }

    task.resume()
}
```

<img width="412" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/152b8d1a-11e0-48c6-87f8-5cfb795f5ac4">
