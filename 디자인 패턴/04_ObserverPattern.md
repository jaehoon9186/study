# 옵저버 패턴 Observer Pattern

주체가 어떤 객체(subject)의 상태 변화를 관찰하다가 상태 변화가 있을 때 마다 메서드 등을 통해 옵저버 목록에 잇는 옵저버들에게 변화를 알려주는 디자인 패턴  
주체란 객체의 상태 변화를 보고 있는 관찰자 이며,  
옵저버들이란 이 객체의 상태 벼화에 따라 전달되는 메서드 등을 기반으로 '추가 변화 사항'이 생기는 객체들을 의미함.  

예제) 
인플루언서 트위터와 구독자들 
인플루언서가 트위터에 피드를 남기면 구독자들에게 알림이 간다. 

구독자들은 매번 인플루언서의 트위터를 보고 있지 않아도 됨. 인플루언서 트위터의 상태변화가 생겼을 때 알람이 오기때문. 


두마리의 포켓몬이 있다. 
파이리, 꼬부기  
기상변화에 따라 두 포켓몬의 스테이터스가 달라진다  
폭염주의보 : 파이리 강화, 꼬부기 약화  
호우주의보 : 파이리 약화, 꼬부기 강화
일상 : 파이리 보통, 꼬부기 보통

예제가 적절한지 잘 모르겠으나 구현해 보자~ 

## swift로 팩토리 패턴 만들어보기

```swift
import UIKit

// Observer Pattern
/*
 protocol Observer: AnyObject {
     var name: ObserverName { get }
     func didChange(name: String, from oldValue: String, to newValue: String)
 }

 protocol Publisher: AnyObject {
     var observers: [Observer] { get }
     func addObserver(name: ObserverName)
     func removeObserver(name: ObserverName)
 }
 */

protocol 옵저버프로토콜 {
    func update(기상: 기상이넘)
}

enum 기상이넘 {
    case 일반
    case 폭염주의보
    case 폭우주의보
}


class 꼬부기클래스: 옵저버프로토콜 {
    func update(기상: 기상이넘) {
        switch 기상{
        case .일반:
            print("꼬부기 일반..")
        case .폭염주의보:
            print("꼬부기 약해짐 ㅠㅠ")
        case .폭우주의보:
            print("꼬부기 강해짐 !!!")
        }
    }
}

class 파이리클래스: 옵저버프로토콜 {
    func update(기상: 기상이넘) {
        switch 기상{
        case .일반:
            print("파이리 일반..")
        case .폭염주의보:
            print("파이리 강해짐 !!!")
        case .폭우주의보:
            print("파이리 약해짐 ㅠㅠ")
        }
    }
}

class 기상퍼블리셔 {
    var 포켓몬들: [옵저버프로토콜] = []
    var 기상: 기상이넘 = 기상이넘.일반 {
        didSet {
            print(기상, "으로 날씨 변경 ")
            for 포켓몬 in 포켓몬들 {
                포켓몬.update(기상: 기상)
            }

        }
    }

    func 포켓몬추가(포켓몬: 옵저버프로토콜) {
        self.포켓몬들.append(포켓몬)
    }

//    func 포켓몬삭제()
}


let 기상퍼블인스턴스 = 기상퍼블리셔()
let 파이리 = 파이리클래스()
let 꼬부기 = 꼬부기클래스()

기상퍼블인스턴스.포켓몬추가(포켓몬: 파이리)
기상퍼블인스턴스.포켓몬추가(포켓몬: 꼬부기)

기상퍼블인스턴스.기상 = 기상이넘.폭우주의보
/*
 폭우주의보 으로 날씨 변경
 파이리 약해짐 ㅠㅠ
 꼬부기 강해짐 !!!
 */

기상퍼블인스턴스.기상 = 기상이넘.폭염주의보
/*
 폭염주의보 으로 날씨 변경
 파이리 강해짐 !!!
 꼬부기 약해짐 ㅠㅠ
 */


```



## 참조

[면접을 위한 CS 전공지식 노트 주홍철 저](https://github.com/gyoogle/tech-interview-for-developer)  
[야곰닷넷 디자인패턴](https://yagom.net/courses/design-pattern-in-swift/)
