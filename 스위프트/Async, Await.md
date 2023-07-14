# async await
[youtube](https://www.youtube.com/watch?v=-5kIzkBqAzc&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=4)

<details>
<summary>코드</summary>
<div markdown="1">
<img width="337" alt="스크린샷 2023-07-14 오후 7 00 22" src="https://github.com/jaehoon9186/study/assets/83233720/de897b5a-615f-4e8d-92a1-8a296a41edad">  
  
```swift
/*
 #3

 Async / Await 키워드가 무엇인지 간단히 알아보자.

 */

import SwiftUI

class AsyncAwaitViewModel: ObservableObject {
    @Published var dataArray: [String] = []

    /*
     1. 쓰레드에 대한 이해가 필요하다.

     Async/Await를 사용할 때 쓰레드를 염두에 두어야 할 것

     main T
     global T


     */
    func addTitle1() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("title1 : \(Thread.current)")
        }
    }

    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "title2 : \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)

                let title3 = "title3 : \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }

    /*

     */
    // 비동기식 작업 수행.
    /*
     Async/Await 환경이라고 해서 반드시 backgound Thread를 사용하는것이 아니다.
     main Thread일수도 있고 backgound Thread 일수도 있다.
     왜?
     */
    func addAuthor1() async {
        let author1 = "Author1 : \(Thread())"

        // async func 이니까
        // main Thread에서 UI를 업데이트 할수 있도록 보장주자.
        // DispatchQueue가 아닌 Actor를 이용해서.
        await MainActor.run {
            self.dataArray.append(author1)
        }

        // DispatchQueue가 아닌 Task를 이용해 보자.
        try? await Task.sleep(nanoseconds: 2_000_000_000)

        let author2 = "Author2: \(Thread())"
        await MainActor.run {
            self.dataArray.append(author2)

            let author3 = "Author3: \(Thread())"
            self.dataArray.append(author3)
        }

//        await addSometing()
    }

    func addSometing() async {

        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something1 = "something1: \(Thread())"
        await MainActor.run {
            self.dataArray.append(something1)

            let something2 = "something2: \(Thread())"
            self.dataArray.append(something2)
        }
    }
}

struct AsyncAwait: View {

    @StateObject private var viewModel = AsyncAwaitViewModel()

    var body: some View {
        List {
            // id 는 각 문자열의 해시 값을 참조해라 \.self
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
//            viewModel.addTitle1()
//            viewModel.addTitle2()
            Task {
                await viewModel.addAuthor1()
                await viewModel.addSometing()

                let finalText = "FINAL TEXT : \(Thread())"
                viewModel.dataArray.append(finalText)
            }
        }
    }
}

struct AsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwait()
    }
}

```

</div>
</details>

