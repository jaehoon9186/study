# Download images, (escaping, async await, combine)
[유튜브 링크](https://www.youtube.com/watch?v=9fXI6o39jLQ&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=3)<br/>


3가지의 방법으로 이미지를 다운로드 한다. 

1. 전통적인 방법 @escaping 키워드, 클로저를 이용
2. Combine 프레임워크를 이용
3. Async/await를 이용


## @escaping
```swift
let url = URL(string: "https://picsum.photos/200")!

func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
    guard let data = data,
          let image = UIImage(data: data),
          let response = response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300 else {
        return nil
    }

    return image
}

func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

        let image = self?.handleResponse(data: data, response: response)
        completionHandler(image, error)
    }
    .resume()
}
```
함수 밖의 공간에서 실행하기 위해 @escaping 키워드를 사용한다.<br/>
<br/>
순서<br/>
dataTask <- 서버에 데이터를 요청하고 받아오는 역할을 해줄 인스턴스<br/>

1. dataTask는 completion handler를 가지고 있음.<br/>
서버에 요청을 하고 응답이 오면 completino handler를 실행해<br/>
이를 위해 클로져를 dataTask에 주는것.<br/>
2. dataTask : 요청. 서버야 데이터 줘<br/>
3. URL Server: 응답.<br/>
4. DataTask : 응답 받음. 응답으로 completion handler 실행.<br/>
<br/>

```swift
func fetchImage() {
    loader.downloadWithEscaping { [weak self] image, error in
        DispatchQueue.main.async {
            self?.image = image
        }
    }
}
```
[weak self] 강한 참조이기로 발생할 문제를 해결하기 위해 사용. <br/>
<br/>

## Combine
```swift
func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
    URLSession.shared.dataTaskPublisher(for: url).map(handleResponse)
        .mapError({ $0 })
        .eraseToAnyPublisher()
}
```
<br/>

```swift
var cancellables = Set<AnyCancellable>()

func fetchImage() {
    loader.downloadWithCombine()
        .receive(on: DispatchQueue.main)
        .sink { _ in

        } receiveValue: { [weak self] image in
            self?.image = image
        }
        .store(in: &cancellables )
}
```
<br/>

## Async / await

```swift
func downloadWithAcync() async throws -> UIImage? {
    do {
        let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
        return handleResponse(data: data, response: response)

    } catch {
        throw error
    }
}
```

```swift
func fetchImage() async {
    let image = try? await loader.downloadWithAcync()
    await MainActor.run {
        self.image = image
    }
}
```
장점 <br/>
1. [weak self] 를 할 필요가 없다. <br/>
2. completion handler에서는 클로져를 호출하지 못하는 경우 문제를 찾기 쉽지 않으나. async/await에서는 필수적으로 강제하여 오류를 찾기 쉬움. 더욱 안전한 코드<br/>
<br/>

```swift
Task {
    await viewModel.fetchImage()
}
```
async 메서드를 호출하려면 async 메서드 내에서 호출하거나, Task로 묶어서 호출해야한다. <br/>
