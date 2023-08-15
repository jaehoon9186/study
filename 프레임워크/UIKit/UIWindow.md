# UIWindow

<img width="961" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/98553b9d-993a-4a73-aa11-5795c49230c5">

UIWindow는 앱 UI를 위한 배경이고 view에 이벤트를 전달하는 객체이다. 


# Overview

window는 events를 다루기 위해서, 앱 동작의 기본이 되는 task들을 수행하기위해서 view controller와 함께 동작합니다. UIKit은 많은 앱 동작을 구현하기위해 필요에 따라 다른 객체와 일하면서 대부분의 window와 관련된 상호작용을 처리합니다. 

다음을 수행해야 하는 경우에 window를 사용합니다:  
* 앱의 콘텐츠를 표시하는 main window를 제공
* 추가적인 콘텐츠를 표시하는 추가적인 window 들을 만듦 (필요에 따라)

일반적으로, Xcode는 앱의 main window를 제공합니다. 새로운 iOS 프로젝트는 앱의 view들을 정의하기위해 스토리보드를 이용합니다. 스토리보드는 app delegate 객체(Xcode templates이 자동으로 제공하는)에 window 프로퍼티의 존재를 요구합니다. 만약 스토리보드를 이용하지 않는다면, 너는 반드시 window를 스스로 만들어야 한다. 

대부분의 앱들은 하나의 window를 필요로 한다. (디바이스의 main screen에 앱의 콘텐츠를 뿌려주는 하나의 window.) 하지만 너는 main screen에 추가적인 window들을 만들 수 있다. 추가 window들은 일반적으로 추가 screen에 콘텐츠를 보여주기 위해 이용된다. 참고 [Presenting content on a connected display](https://developer.apple.com/documentation/uikit/windows_and_screens/presenting_content_on_a_connected_display)

또한 몇 가지 다른 task를 다루기 위해 UIWindow 객체를 사용합니다:  
* window의 z-axis 를 셋팅하기 위해, which affects the visibility of the window relative to other windows.
* window를 표시하고, keyboard event의 대상으로 지정
* window의 좌표 시스템에서 좌표값으로 변환
* window의 root view controller를 변경
* window가 보여지는 screen 변경

window 들은 시각적인 외형을 가지고 있지 않습니다. 대신, window는 (window의 root view controller에 의해 관리되는) 하나 이상의 view 들을 호스트 합니다. 너의 인터페이스에 적합한 view들을 추가하여 스토리보드에서 root view controller를 구성하세요. 

UIWindow subclass는 거의 필요 없습니다. window에서 상향시키기 위한 동작의 중류들은 상위수준인 view controller에서 더 쉽게 구현할 수 있습니다. subclass가 필요한 몇가지의 경우 중 하나는 window's key status가 변경될 때 `becomeKey()`와 `resignKey()` 메소드를 커스텀 동작으로 override 하기 위해서 인 경우 일 것입니다. 어떻게 window를 특정 screen에 표시하는지에 대하서는 [UIScreen](https://developer.apple.com/documentation/uikit/uiscreen)을 참고하세요. 


# Understand keyboard interactions

터치 이벤트는 발생한 window로 전달 되는 반면, 관련 좌표값이 없는 이벤트들은 key window로 전달됩니다. 한번에 하나의 window만 key window가 될 수 있고, window's `isKeyWindow` 프로퍼티를 사용해서 그것의 상태를 결정할(확인할) 수 있습니다. 대부분, 앱의 main window가 key window입니다만, UIKit은 필요에 따라 다른 window를 지정할 수도 있습니다. 

만약 어떤 window가 key인지 확인이 필요하다면, `didBecomeKeyNotification`과 `didResignKeyNotification` notifications 를 observe하세요. 그 시스템은 앱의 key window의 변경에 대한 응답으로 이러한 notification을 보냅니다. window가 key로 강제하기 위해서 또는 key 상태를 해제 하기 위해선, 이 클래서의 적절한 메소드를 호출 하세요. 

