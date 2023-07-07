//
//  ContentView.swift
//  DownloadImage
//
//  Created by LeeJaehoon on 2023/07/06.
//

import SwiftUI
import Combine


class DownloadImageAsyncImageLoader {

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
        /*
         함수 밖의 공간에서 실행하기 위해 @escaping 키워드를 사용한다.
         */
        /*
         순서
         dataTask <- 서버에 데이터를 요청하고 받아오는 역할을 해줄 인스턴스

         1. dataTask는 completion handler를 가지고 있음.
         서버에 요청을 하고 응답이 오면 completino handler를 실행해
         이를 위해 클로져를 dataTask에 주는것.

         2. dataTask : 요청. 서버야 데이터 줘

         3. URL Server: 응답.

         4. DataTask : 응답 받음. 응답으로 completion handler 실행.

         */
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in

            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }

    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url).map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }

    func downloadWithAcync() async throws -> UIImage? {

        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)

        } catch {
            throw error
        }
    }
}


class DownloadImageAsyncViewModel: ObservableObject {

    @Published var image: UIImage? = nil
    let loader = DownloadImageAsyncImageLoader()
    var cancellables = Set<AnyCancellable>()

    func fetchImage() async {

        /*
         // @escaping
        loader.downloadWithEscaping { [weak self] image, error in
            DispatchQueue.main.async {
                self?.image = image
            }
            
        }
         */

        /*
         Combine
        loader.downloadWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in

            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables )
         */

        // async / await
        // 장점 1. [weak self] 를 할 필요가 없다.
        // 2. completion handler에서는 클로져를 호출하지 못하는 경우 문제를 찾기 쉽지 않으나. async/await에서는 필수적으로 강제하여 오류를 찾기 쉬움. 더욱 안전한 코드
        let image = try? await loader.downloadWithAcync()
        await MainActor.run {
            self.image = image
        }

    }
}

struct ContentView: View {

    @StateObject private var viewModel = DownloadImageAsyncViewModel()


    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear {
//            viewModel.fetchImage()

            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
