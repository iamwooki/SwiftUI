# 컨테이너 정렬
- (implicitly aligned) 가장 기본적인 정렬 방법, 스택에 적용한 정렬이 하위 뷰에 적용 됨
```swift
/*
VStack, HStack, ZStack
default: .center
*/
ex)
VStack(alignment: .trailing){} //right
HStack(alignment: .leading){} //left
ZStack(alignment: .center){} //center
```

- 텍스트 베이스라인 정렬
```swift
VStack(alignment: .firstTextBaseline) //첫째 줄 기준
HStack(alignment: .lastTextBaseline) //마지막 줄 기준
```

# alignmentGuide(), 커스텀 가이드
ref : http://bit.ly/2MCioyl

- alignmentGuide() 수정자를 이용하여 정렬 위치 계산을 돕기 위해 뷰의 폭과 높이를 얻는데 사용하는 ViewDimensions 객체와 뷰의 표준 정렬 위치 가(.top, .bottom, .leading 등)클로저에 전달
```Swift
//수정자에 지정된 정렬타입과 부모 스택에 적용된 정렬 타입이 일치해야함
VStack(alignment: .leading){
    Rectangle()
        .alignmentGuide(.leading, computeValue:  {d in 120.0 })
}
```
- offset을 하드코딩하는 대신, 클로저에 전달된 ViewDimensions 객체의 프로퍼티 정렬 가이드 위치를 계산하는데 이용 가능
```swift
VStack(alignment: .leading){
    Rectangle()
        .alignmentGuide(.leading, computeValue: { d in d.width / 3})
}
```
- ViewDimensions 객체는 뷰의 HorizontalAlignment와 VerticalAlignment 프로퍼티에 대한 접근을 제공
```swift
.alignmentGuide(.leading, computeValue: {
    d in d[HorizontalAlignment.triling] + 20
})
```

## - 커스텀 정렬 타입
- ```extension```을 이용해 새로운 정렬 타입을 생성 할 수 있음

Define)
```swift
//형식 지켜야함
extension VerticalAlignment{
    private enum 커스텀정렬이름 : AlignmentID{
        static func defaultValue(in d: ViewDimensions)-> CGFloat {
            return d.height / 3 //원하는 위치 값
        }
    }
    static let oneThird = verticalAlignment(커스텀정렬이름.self)
}
```
Use)
```swift
HStack(alignment : .커스텀정렬이름){
    //content
}
```
- ZStack의 하위 뷰에 대한 커스텀 정렬은 ```HorizontalAlignmentGuide```와 ```VerticalAlginmentGuide``` 모두가 필요함
