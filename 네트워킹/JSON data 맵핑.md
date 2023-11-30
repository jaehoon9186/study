# JSON data 맵핑

### 참고
* [iOS Swift Tutorial - Working with the Web - How to parse JSON into model objects with Codable
 / youtube](https://www.youtube.com/watch?v=6yelg66Z0BQ&list=PLWHegwAgjOko-_H8MPHbPJbA24Gel2fg_&index=2)
* [Encoding and Decoding Custom Types / apple docs](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types)

### Tool
- [model 생성](https://app.quicktype.io/)

### 서두
JSON 데이터를 swift 에서 사용할 모델로 디코딩 하려고 합니다. 그런데 키값이 스네이크케이스라면? (swift에서는 카멜케이스사용), 데이터 형식을 변환하고 싶다면?
이럴땐 어떻게 해야할까요.

# 예제

```swift
let jsonData = """
{
    "weight":{
        "imperial":"7  -  10",
        "metric":"3 - 5"
    },
    "id":"abys",
    "name":"Abyssinian",
    "description":"The Abyssinian is easy to care for, and a joy to have in your home.
                  They’re affectionate cats and love both people and other animals.",
    "hairless":0,
    "reference_image_id":"0XYvRd7oD"
}
""".data(using: .utf8)!
```
위와 같은 데이터를 저장할 모델을 만들고자 합니다.  
고양이의 종, 특징 등을 가지고있는 json 데이터입니다.   

```swift
struct Breed: Codable, CustomStringConvertible {
    let id: String
    let name: String

    var description: String {
        return "종: \(name), id: \(id)"
    }
}
```
id, name 키값은 문제없이 사용할 수 있었습니다. 그리고 ```CustomStringConvertible```프로토콜을 채택 description 프로퍼티를 구현하여 디버깅용으로 사용하려고 합니다.   
  
나머지 키값도 mapping해줘야하는데..  
* 'weight'는 nested json으로 구성되어 있고.   
* 'description'은 디버깅용으로 만든 description프로퍼티와 중복인 상황,   
* 'hairless' 는 0, 1로 구분되어 있는 키값인데 Bool type으로 바꾸고 싶고,   
* 'reference_image_id'는 스네이크 케이스로 표기되어 있어 카멜케이스로 바꿔줘야 합니다.
* 추가적인 상황을 고려해 'reference_image_id'는 json data 없을 수 있습니다.

```swift
struct Breed: Codable, CustomStringConvertible {
    let id: String
    let name: String
    let weight: BreedWeight
    let breedDescription: String
    let isHairless: Bool
    let imageId: String?

    var description: String {
        return "종: \(name), id: \(id), 무게: \(weight), \n 설명: \(breedDescription), \n
                털 유무: \(isHairless ? "있음" : "없음"), 이미지아이디: \(imageId ?? "아이디없음")"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case weight
        case breedDescription = "description"
        case isHairless = "hairless"
        case imageId = "reference_image_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        weight = try values.decode(BreedWeight.self, forKey: .weight)
        breedDescription = try values.decode(String.self, forKey: .breedDescription)
        let hairless = try values.decode(Int.self, forKey: .isHairless)
        isHairless = hairless == 1

        /*
        do {
            imageId = try values.decode(String.self, forKey: .imageId)
        } catch {
            imageId = nil
            print(error.localizedDescription)
            // debug: The data couldn’t be read because it is missing.
        }
         */
//        imageId = try? values.decode(String.self, forKey: .imageId)
        imageId = try values.decodeIfPresent(String.self, forKey: .imageId)
    }
}

struct BreedWeight: Codable {
    let imperial: String
    let metric: String
}

let jsonDecoder = JSONDecoder()

if let breed = try? JSONDecoder().decode(Breed.self, from: jsonData) {
    print(breed)
}
```

<img width="1137" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/8c66c00e-985a-4b80-a1ba-530fe1d7b489">
(예제 jsonData 중 reference_image_id 키 값은 지웠습니다.)
</br></br></br>

nested json의 경우 또 다른 모델을 정의하여 해결할 수 있고, 
</br>

키의 명칭을 다르게 하여 모델을 만들기 위해서는 CodingKey를 사용할 수 있습니다. 
</br>

isHairless 프로퍼티의 경우 JSON에서는 1 or 0 으로 Int형이지만 Bool형으로 변환하였습니다.  
이때는 사용자 정의로 init을 할 수 있도록 init(from decoder: Decoder)를 통해 구현할 수 있습니다.   
decoder.container(keyedBy: CodingKeys.self)메소드는 이전에 정의된 코딩키를 바탕으로 디코더에 저장된 값들을 가져오는 메서드이며 가져온정보를 바탕으로 프로퍼티를 초기화해주면됩니다. 
</br>

마지막으로 imageId의 경우 값의 유무를 모르기때문에 옵셔널로 처리하였습니다.   
이땐, decode() 메서드 대신에 decodeIfPresent() 메서드를 사용하면됩니다. 차이는 decodeIfPresent()는 옵셔널로 리턴합니다. 아니면 try? 를 사용하는 방법도 있습니다. 

만약 프로퍼티의 속성을 옵셔널로 하기 싫다면 init() 에서 nil일 때의 정해진 초기값을 할당하는것도 방법일 것 같습니다. 


 








