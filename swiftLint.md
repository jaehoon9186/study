## Swift Lint

[스위프트 깃허브 링크](https://github.com/realm/SwiftLint)
  
설치, 적용법 리드미 참조

### 1. 다운로드


### 2. 적용
> Script 생성
<img width="820" alt="스크린샷 2023-05-25 오전 11 32 21" src="https://github.com/jaehoon9186/study/assets/83233720/cbbec220-f899-4bf8-839e-d4908275134a">

```taget```->```Build Phases```->```New Run Script Phase```

> Script 작성 

<img width="683" alt="스크린샷 2023-05-25 오전 11 38 18" src="https://github.com/jaehoon9186/study/assets/83233720/cfa7a606-37af-49c5-b73d-754566fa64f8">

```
if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if which swiftlint > /dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
```

> Script 우선순위 조정

<img width="770" alt="스크린샷 2023-05-25 오전 11 50 45" src="https://github.com/jaehoon9186/study/assets/83233720/c342c25b-5f52-4e0c-b56a-a5c6187f4331">    

Complie Sources 위로 Script를 위치시킴. 컴파일전에 린트를 검사하는것이 효율적이라고 한다. 

### 3. 룰 수정하기
이전과정까지 적용하면 기본룰이 적용됨. 세부적으로 설정하기 위해서 아래 과정을 진행한다. 
  
> .swiftlint.yml 생성  
 <img width="738" alt="스크린샷 2023-05-25 오후 2 38 09" src="https://github.com/jaehoon9186/study/assets/83233720/7d57de41-a066-410e-8702-9a64120376a9">

<img width="804" alt="스크린샷 2023-05-25 오후 2 38 41" src="https://github.com/jaehoon9186/study/assets/83233720/9404f48d-f5c4-416b-aa20-ec1109018e77">


> 룰 수정 
.swiftlint.yml 파일에 적용할 룰을 적어준다. 
```
disabled_rules: # 실행에서 제외할 룰 식별자들
  - colon
  - comma
  - control_statement
opt_in_rules: # 일부 룰은 옵트 인 형태로 제공
  - empty_count
  - missing_docs
  # 사용 가능한 모든 룰은 swiftlint rules 명령으로 확인 가능
included: # 린트 과정에 포함할 파일 경로. 이 항목이 존재하면 `--path`는 무시됨
  - Source
excluded: # 린트 과정에서 무시할 파일 경로. `included`보다 우선순위 높음
  - Carthage
  - Pods
  - Source/ExcludedFolder
  - Source/ExcludedFile.swift

# 설정 가능한 룰은 이 설정 파일에서 커스터마이징 가능
# 경고나 에러 중 하나를 발생시키는 룰은 위반 수준을 설정 가능
force_cast: warning # 암시적으로 지정
force_try:
  severity: warning # 명시적으로 지정
# 경고 및 에러 둘 다 존재하는 룰의 경우 값을 하나만 지정하면 암시적으로 경고 수준에 설정됨
line_length: 110
# 값을 나열해서 암시적으로 양쪽 다 지정할 수 있음
type_body_length:
  - 300 # 경고
  - 400 # 에러
# 둘 다 명시적으로 지정할 수도 있음
file_length:
  warning: 500
  error: 1200
# 네이밍 룰은 경고/에러에 min_length와 max_length를 각각 설정 가능
# 제외할 이름을 설정할 수 있음
type_name:
  min_length: 4 # 경고에만 적용됨
  max_length: # 경고와 에러 둘 다 적용
    warning: 40
    error: 50
  excluded: iPhone # 제외할 문자열 값 사용
identifier_name:
  min_length: # min_length에서
    error: 4 # 에러만 적용
  excluded: # 제외할 문자열 목록 사용
    - id
    - URL
    - GlobalAPIKey
reporter: "xcode" # 보고 유형 (xcode, json, csv, codeclimate, checkstyle, junit, html, emoji, sonarqube, markdown, github-actions-logging)
```
