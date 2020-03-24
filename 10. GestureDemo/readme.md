# Gesture
: 터치스크린과의 인터랙션
> - 드래그, 탭, 더블 탭, 핀칭(확대/축소), 로테이션, 롱 프레스 등

### 제스처 인식기(Gesture recognizer)
>: 인식기는 하나 이상의 액션 콜백을 포함, 콜백은 일치하는 제스처가 뷰에서 감지 될때 동작
- TapGesture()
```Swift
struct ContentView: View {
    var body: some View {
        Image(systemName: "hand.point.right.fill")
        .gesture(
            TapGesture()
            .onEnded({_ in
                print("Tapped")
                
            })
        )
    }
}
```
```Swift
//TapGesture()
struct ContentView: View {
    var body: some View {
        let tap = TapGesture() //TapGesture(count:횟수)를 이용하면 특정 횟수만 동작하도록 
            .onEnded({_ in
                print("Tapped")
        })
        
        return Image(systemName: "hand.point.right.fill")
            .gesture(tap)
    }
}
```
- LongPressGesture()
```Swift
//LongPressGesture()
//minimumDuration : 최소 시간 값(초단위)
//maximumDistance : 화면상의 접촉점이 뷰밖으로 이동할 수 있는 최대거리
let tap = LongPressGesture(minimumDuration: 10, maximumDistance: 25)
    .onEnded { _ in
        print("Long Press")
    }
```
- 제스처 인식기 제거
```Swift
.gesture(nil)
```

### onChanged() action call-back
>: TapGesture()를 제외한 다른 많은 제스처 인식기는 onChanged() 액션 콜백을 지원한다.
>>(!) 제스처가 처음 인식되었을 때 호출되며, 제스처가 끝날 때까지 제스처의 값이 변할때마다 호출됨 (제스처 진행 알림)
```Swift
let magnificationGesture = MagnificationGesture(minimumScaleDelta: 0)
    .onChanged( { _ in
        print("Magnifying")
    })
    .onEnded {_ in
        print("Gesture Ended")
    }
```
Example) 확대 제스처에 따른 이미지 스케일링
```Swift
struct ContentView: View {
    @State private var magnification: CGFloat = 1.0
    
    var body: some View {
        let magnificationGesture = MagnificationGesture(minimumScaleDelta: 0)
            .onChanged({value in
                self.magnification = value
            })
            .onEnded({_ in
                print("Gesture Ended")
            })
        
        return Image(systemName: "hand.point.right.fill")
            .resizable()
            .font(.largeTitle)
            .scaleEffect(magnification)
            .gesture(magnificationGesture)
            .frame(width:100, height:90)
    }
}
```
### Updating() action call-back
>: onChanged와 비슷하나 ```@GestureState``` 특별한 프로퍼티 래퍼를 사용
>>```@GestureState```: 제스처와 함께 사용되도록 설계, 제스처가 끝나면 자동으로 원래 상태 값으로 리셋됨, 필요한 동안에만 사용하는 임시 상태 저장에 최적

>> updating() 호출 시
>> - 제스처에 대한 정보가 담겨 있는 DragGesture.value 객체
>> - 제스처가 바인딩되어 있는 @GestureState 프로퍼티 참조체
>> - 제스처에 해당하는 애니메이션의 현재 상태를 담은 Transaction 객체

>> ```DragGesture.value Property```
>> - ```location (CGPoint)```: 드래그 제스처의 현재 위치
>> - ```predictedEndLocation (CGPoint)``` : 현재의 드래그 속도를 바탕으로 드래그가 멈추게 된다면 예상되는 최종 위치
>> - ```predictedEndTranslation (CGSize)``` : 현재의 드래그 속도를 바탕으로 드래그를 멈추게 된다면 예상되는 최종 오프셋
>> - ```startLocation (CGPoint)``` : 드래그 제스처가 시작된 위치
>> - ```time (Date)``` : 현재 드래그 이벤트가 발생한 타임스탬프
>> - ```translation (CGsize)``` : 드래그 제스처를 시작한 위치부터 현재 위치까지의 offset

Example) 드래그 제스처가 끝나면 Image 뷰는 원래 위치로 돌아감
```swift
struct SecondView: View {
    //드래그 제스처를 시작한 위치부터 현재 위치까지의 offset
    @GestureState private var offset: CGSize = .zero
    
    var body: some View {
        let drag = DragGesture()
            .updating($offset) { dragValue, state, transaction in
                state = dragValue.translation
        }
        return Image(systemName: "hand.point.right.fill")
            .font(.largeTitle)
            .offset(offset)
            .gesture(drag)
    }
}
```

# 제스처 구성
- ```simultaneously``` : 두 개의 제스처가 동시에 감지되어야 해당 동작 수행
- ```sequenced``` : 두번째 제스처가 감지되기 전에 첫번째 제스처가 완료되어야 함
- ```exclusively``` : 둘 중 하나의 제스처가 감지되면 다 감지된 것으로 간주

Example) 롱 프레스 제스처와 드래그 제스처를 동시적 구성
```swift
//GestureConstrctionView2.swift
let longPressAndDrag = LongPressGesture(minimumDuration: 1.0)
    //롱 프레스 진행
    .updating($longPress) { value, state, transition in
        state = value
    }
    //동시에 드래그 진행가능
    .simultaneously(with: DragGesture())
        .updating($offset) { value, state, transaction in
            state = value.second?.translation ?? .zero
    }
```
Example) 롱 프레스 제스처와 드래그 제스처를 순차적 구성
```swift
//GestureConstructionView.swift
let longPressBeforeDrag = LongPressGesture(minimumDuration: 2.0)
    .onEnded( { _ in
        //롱 프레스가 끝나면 트리거
        self.dragEnabled = true
    })
    //순차적으로 드래그 작업 시작
    .sequenced(before: DragGesture())
    .updating($offset) { value, state, transaction in
        switch value{
            case .first(true):
                print("Long press in progress")
            case .second(true, let drag):
                state = drag?.translation ?? .zero
                    
            default: break
        }
    }
    .onEnded{ value in
        self.dragEnabled = false
    }
```