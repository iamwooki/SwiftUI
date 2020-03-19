# 상태프로퍼티
- 바인딩되도록 선언하기 때문에 문자앞에 '$'
```swift
@state private var rotation: Double = 0

var body: some view{
  VStack{
    Slider(value:$rotation, in:0 ... 360, step: 0.1)
    }
}
```
# 레이아웃 정리

```Swift
.padding() //뷰 주변에 여백을 추가하여 디바이스 화면 끝에 너무 가깝게 붙지 않도록

Spacer() //뷰들 사이에 가벼적인 공간을 제공해서 레이아웃의 필요에 따라 뷰가 확장/축소 되도록

Divider() //스택 컨테이너 안의 두 뷰 사이가 분리됨을 나타내는 라인을 그림
```

# ForEach
- 동적 뷰 생성을 위해
```swift
ForEach ( 0 ..< 변수 ){  // 0 ~ 변수-1 cf) 0 ... 변수 : 0 ~ 변수
  //content
}
```
