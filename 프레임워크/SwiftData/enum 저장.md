# enum 저장

Codable과, RawRepresentable을 채택해야함.  

단순한 구조의 enum은 가볍게 가능하지만, associated enum의 경우 직접 구현해주어야함.  

swift 5.5 이상에서는 Codable을 채택하면 자동으로 구현된다하는데. 이하의 버전이라하면 이하와 같이 참고할것 (링크도)  

기존엔 두개의 enum을 비교하기위해 pathID를 사용했으나, RawRepresentable을 채택하고 rawValue를 유니크하게 구현하여서 필요없을듯.  




```swift
enum VoiceNumberType: String, CaseIterable, Codable, VoiceTypeable {
    static var allVoiceCases: VoiceTypeTree {
        VoiceTypeTree(description: Self.description, leafs: VoiceNumberType.allCases.map { VoiceType.number($0) })
    }

    static var description: String {
        "넘버타입"
    }

    var pathID: String {
        "/" + Self.description + "/" + self.rawValue
    }

    var midi: Int {
        switch self {
            //        case .eight:
        default:
            return 0
        }
    }

    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case eleven
    case twelve
}

enum VoicePhoneticType: String, CaseIterable, Codable, VoiceTypeable {
    static var allVoiceCases: VoiceTypeTree {
        VoiceTypeTree(description: Self.description, leafs: VoicePhoneticType.allCases.map { VoiceType.phonetic($0) })
    }

    static var description: String {
        "음성타입"
    }

    var pathID: String {
        "/" + Self.description + "/" + self.rawValue
    }

    var midi: Int {
        switch self {
            //        case .a:
        default:
            return 0
        }
    }

    case e
    case an
    case a
    case tri
    case plet
    case ta
    case ki
    case ka
    case ke
    case tuh
}

// 마찬가지로 all cases가 있어야하고,
enum VoiceType: Hashable {
    // beatCount(현재 비트숫자에  / voiceNumberType
    // 나머지는 / voiceETCType
    //    allSoundCases

//    static func == (lhs: VoiceType, rhs: VoiceType) -> Bool {
//        lhs.pathID == rhs.pathID
//    }

    static var allVoiceCases: VoiceTypeTree {
        VoiceTypeTree(description: Self.description, childs: [])
    }

    static var description: String {
        "보이스타입"
    }

    var pathID: String {
        "/" + Self.description + "/" + detailType.pathID
    }

    var midi: Int {
        detailType.midi
    }

    case number(VoiceNumberType)
    case phonetic(VoicePhoneticType)

    private var detailType: any VoiceTypeable {
        switch self {
        case .number(let numberType):
            return numberType
        case .phonetic(let phonetic):
            return phonetic
        }
    }
}

extension VoiceType: RawRepresentable {
    private static let numberPrefix = "number:"
    private static let phoneticPrefix = "phonetic:"

    init?(rawValue: String) {
        if rawValue.hasPrefix(VoiceType.numberPrefix) {
            let value = rawValue.dropFirst(VoiceType.numberPrefix.count)
            if let number = VoiceNumberType(rawValue: String(value)) {
                self = .number(number)
                return
            }
        }
        if rawValue.hasPrefix(VoiceType.phoneticPrefix) {
            let value = rawValue.dropFirst(VoiceType.phoneticPrefix.count)
            if let phonetic = VoicePhoneticType(rawValue: String(value)) {
                self = .phonetic(phonetic)
                return
            }
        }
        return nil
    }

    var rawValue: String {
        switch self {
        case .number(let value):
            return VoiceType.numberPrefix + value.rawValue
        case .phonetic(let value):
            return VoiceType.phoneticPrefix + value.rawValue
        }
    }
}

// https://github.com/swiftlang/swift-evolution/blob/main/proposals/0295-codable-synthesis-for-enums-with-associated-values.md#codable-synthesis-for-enums-with-associated-values

// https://stackoverflow.com/questions/68492202/how-to-make-a-swift-enum-with-associated-values-conform-to-codable

extension VoiceType: Codable {
    private enum CodingKeys: CodingKey {
        case number, phonetic
    }
    private enum NumberCodingKeys: CodingKey {
        case numberType
    }
    private enum PhoneticCodingKeys: CodingKey {
        case phoneticType
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .number(number):
            var nestedContainer = container.nestedContainer(keyedBy: NumberCodingKeys.self, forKey: .number)
            try nestedContainer.encode(number, forKey: .numberType)
        case let .phonetic(phonetic):
            var nestedContainer = container.nestedContainer(keyedBy: PhoneticCodingKeys.self, forKey: .phonetic)
            try nestedContainer.encode(phonetic, forKey: .phoneticType)
        }
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
          if container.allKeys.count != 1 {
            let context = DecodingError.Context(
              codingPath: container.codingPath,
              debugDescription: "Invalid number of keys found, expected one.")
            throw DecodingError.typeMismatch(VoiceType.self, context)
          }

        switch container.allKeys.first.unsafelyUnwrapped {
        case .number:
            let nestedContainer = try container.nestedContainer(keyedBy: NumberCodingKeys.self, forKey: .number)
            self = try .number(nestedContainer.decode(VoiceNumberType.self, forKey: .numberType))
        case .phonetic:
            let nestedContainer = try container.nestedContainer(keyedBy: PhoneticCodingKeys.self, forKey: .phonetic)
            self = try .phonetic(nestedContainer.decode(VoicePhoneticType.self, forKey: .phoneticType))
        }
    }
}

protocol VoiceTypeable {
    var midi: Int { get }
    var pathID: String { get }
}

struct VoiceTypeTree: Hashable {
    let description: String
    let leafs: [VoiceType]
    let childs: [VoiceTypeTree]

    init(description: String, leafs: [VoiceType] = [], childs: [VoiceTypeTree] = []) {
        self.description = description
        self.leafs = leafs
        self.childs = childs
    }
}
```
