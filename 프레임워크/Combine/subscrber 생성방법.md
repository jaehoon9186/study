# subscrber 생성방법

```Subscriber``` 프로토콜을 채택해 subscriber를 직접 만들어 줄수 있지만.   

combine은 더욱 쉽게 만들수 있는 방법을 제공해 줍니다.  

1. [sink(receiveCompletion:receiveValue:), documentation](https://developer.apple.com/documentation/combine/publisher/sink(receivecompletion:receivevalue:))
2. assign(to: on:)
3. assign(to: )


# sink(receiveCompletion:receiveValue:)
<img width="1042" alt="image" src="https://github.com/jaehoon9186/study/assets/83233720/53deea68-f763-4d62-99f6-589d09037a48">


publisher의 인스턴스 메소드로 sink를 사용하여 subscription을 생성해 줄 수 있습니다. 

