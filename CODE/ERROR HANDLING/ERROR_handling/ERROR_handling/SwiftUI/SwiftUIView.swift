//
//  SwiftUIView.swift
//  ERROR_handling
//
//  Created by LeeJaehoon on 2023/07/03.
//

import SwiftUI

class ErrorHandlingDataManager {

    let isActive: Bool = false

    // 튜플로 에러 전달.
    // 성공, 실패의 경우 모두 튜플로 불필요한 정보까지 보낸다 더 개선한다면?
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("new text", nil)
        } else {
//            return (nil, URLError(.badURL))
            return (nil, TestError.notActive)
        }
    }

    // Result 로 전달
    // Result<Any, <#Failure: Error#>>
    // 성공, 실패 두가지 모두를 반환 하지 않는다. 한가지의 결과만을 반환.
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("new text")
        } else {
            return .failure(TestError.notActive)
        }
    }


    // 함수 / 함수명 / 리턴이 실패한다면 throws error / 리턴은 스트링으로
    func getTitle3() throws -> String {
        if isActive {
            return "new text"
        } else {
            throw TestError.notActive
        }
    }



}

class ErrorHandlingViewModel: ObservableObject {

    @Published var text: String = "start text.."
    let manager = ErrorHandlingDataManager()

    func fetchTitle() {
        /*
        let returnedValue = manager.getTitle()
        if let newTitle = returnedValue.title {
            self.text = newTitle
        } else if let error = returnedValue.error {
            self.text = error.localizedDescription
        }
         */

        /*
        let result = manager.getTitle2()

        switch result {
        case .success(let newTitle):
            self.text = newTitle
        case .failure(let error):
            self.text = error.localizedDescription
        }
         */

        do {
            // 얻을려고 시도한다. 에러가 발생하면 어디서 잡지?
            let newTitle = try manager.getTitle3()
            // 여러번의 try 가 가능하지면 한번 실패하면 catch로
//            let newTitle = try manager.getTitle3()
//            let newTitle = try manager.getTitle3()
//            let newTitle = try manager.getTitle3()
//            let newTitle = try manager.getTitle3()
//            let newTitle = try manager.getTitle3()
            self.text = newTitle
        } catch let error {
            self.text = error.localizedDescription
        }

        /*
         // 암시적으로 작동하도록도 가능하다.
         { catch {
            self.text = error.localizedDescription
         }
         */

        // 옵셔널로 try
        // catch로 오류를 전달하지 않는다. do-catch 문이 필요없음. 
        // 따로 처리가 필요없는 error나 서드파티같은것들 옵셔널로 처리하여 절약할수 있다.
        let newTitle = try? manager.getTitle3()

        // 강제 언래핑, 권장되지 않음.
        // error throw 비활성화한다.
        // 오류가 발생하면 런타임 에러가 발생한다.
        let newTitleUnwrapping = try! manager.getTitle3()

    }
}

struct SwiftUIView: View {

    @StateObject private var vm = ErrorHandlingViewModel()

    var body: some View {

        Text(vm.text)
            .frame(width: 300, height: 300)
            .background(Color.green)
            .onTapGesture {
                vm.fetchTitle()
            }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
