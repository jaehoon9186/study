# network request 재사용성 높이기

카카오 API를 이용해 간단한 검색 앱을 만들고 있습니다. 
총 3개의 탭뷰로 통합(웹)검색, 비디오검색, 이미지검색을 요청하려고 했습니다.  
각각의 모델에 맞는 요청을 할 것으로 구상을 했는데, 다른것이라곤 모델의 종류만 다르고 나머지는 단계중 다른것이 없어.  
합성(Composition)을 이용해 재사용성을 높이고자 했습니다.  

```swift
// APIService Class
func fetchSearchResult<T: Decodable>(_ type: T.Type, request: URLRequest?, completion: @escaping (Result<T, APIError>) -> Void) {
    guard let request = request else {
        let error = APIError.invalidRequest
        completion(Result.failure(error))
        return
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in

        if let error = error {
            completion(Result.failure(APIError.transportError(error)))
        }

        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) == false {
            completion(Result.failure(APIError.badResponse(stateCode: response.statusCode)))
        }

        if let data = data {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(formatter)

            do {
                let result = try decoder.decode(type, from: data)
                completion(Result.success(result))
            } catch {
                completion(Result.failure(APIError.parsingError))
            }

        }

    }

    task.resume()
}
```
제네릭 이용하여 디코딩할 모델을 입력받습니다, 이때, 제약을 프로토콜인 Decodable로하여 Codable로 정의된 모델만 가능하도록 하였습니다.  
컴플리션핸들러로 반환할 반환값도 제네릭으로.  



```swift
// in ViewModel
// Model: WebSearch
service.fetchSearchResult(WebSearch.self, request: request) { [weak self] result in
    switch result {
    case .success(let value):
        print(value.webResults)
    case .failure(let error):
        print(error.description)
    }
}
```
뷰모델에서의 호출은 위와 같습니다. 모델 타입으로 호출.
