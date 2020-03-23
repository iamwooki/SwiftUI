# Animation
### 암묵적 애니메이션(implicit animation)
- ```.linear``` : 지정된 시간 동안 일정한 속도로
- ```.easeOut``` : 빠른속도로 시작 점점 느려짐
- ```.easeIn``` : 느린속도로 시작 점점 빨라짐
- ```.easeInOut``` : 느린속도로 시작 점점 빨라지다가 다시 느려짐

>>```(수정자 순서 유의)```애니메이션 수정자를 사용할 경우 수정자 이전에 적용된 수정자들에만 애니메이션이 암묵적으로 적용됨
```Swift

struct ContentView: View {
    @State var rotation: Double = 0
    @State private var scale: CGFloat = 1
    
    var body: some View {
        Button(action: {
            self.rotation = (self.rotation < 360 ? self.rotation + 60 : 0 )
            self.scale = (self.scale < 2.8 ? self.scale + 0.3 : 1)
        }) {
            Text("click to animate")
                .scaleEffect(scale) //scale효과
                .rotationEffect(.degrees(rotation)) //회전효과
                //선형시간
                .animation(.linear(duration:1))
                //spring 효과
                .animation(.spring(response: 1, dampingFraction: 0.2, blendDuration: 0))
        }
        
    }
}
```
### 애니메이션 반복
```Swift
/*
duration : 시간
autoreverses: false 애니메이션을 반복하기전 뷰의 원래 모양으로 즉시 되돌려야 하는 경우
*/

.animation(Animation.linear(duration:1).repeatCount(2, autoreverses:false))
```

### 명시적 애니메이션
- ```withAnimation()``` 클로저 내에서 변경된 프로퍼티만 애니메이션 됨
```swift
            Button(action: { withAnimation(.linear(duration: 2)){
                self.rotation = (self.rotation < 360 ? self.rotation + 60 : 0)
                }
                self.scale = (self.scale < 2.8 ? self.scale + 0.3 :1)
            }) {
                Text("Coick to animate")
                    .rotationEffect(.init(degrees: rotation))
                .scaleEffect(scale)

            }
```

### 애니메이션과 상태 바인딩
```swift
struct ContentView: View {
    @State private var visibility = false
    
    var body: some View {
        VStack{
            Toggle(isOn: $visibility.animation(.linear(duration: 0.5))){
                Text("Toogle Text Views")
            }.padding()
            
            if visibility {
                Text("hello world").font(.largeTitle)
            }
            
            if !visibility {
                Text("GoodBye world").font(.largeTitle)
            }
        }
        
        
    }
}
```

### 자동으로 애니메이션 시작
- 사용자 인터랙션 없이 애니메이션을 시작해야 할 때가 있음
- 애니메이션이 간으한 뷰의 프로퍼티가 변경될 때 마다 애니메이션이 트리거 되므로 뷰가 나타날 때 자동으로 시작됨

```swift
struct ContentView: View {
    @State private var isSpinning: Bool = true
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .stroke(lineWidth:2)
                    .foregroundColor(.blue)
                    .frame(width:360,  height:360)
                
                Image(systemName : "forward.fill")
                    .font(.largeTitle)
                    .offset(y:-180)
                    .rotationEffect(.degrees(360))
                    .animation(Animation.linear(duration:1).repeatForever(autoreverses:false))
                    
            }
            .onAppear(){
                self.isSpinning.toggle()
            }
        }
        
        
    }
}
```

# SwiftUI 전환
- 시각적으로 멋지게 보이도록
- ```.slide``` : 뷰가 슬라이딩
- ```.scale``` : 뷰가 커지면서 나타나고 작아지면서 사라짐
- ```.move(edge: edge)``` : 지정된 방향으로 뷰가 이동/추가/삭제
- ```.opacity``` : 디폴트 전환 효과로 페이드되는 동안 크기와 위치를 유지

```swift
struct ContentView: View {
    @State var rotation: Double = 0
    @State private var scale: CGFloat = 1
    @State private var visibility = false
    @State private var isSpinning: Bool = true
    @State private var isButtonVisible: Bool = true
    
    var body: some View {
        VStack{
            Toggle(isOn:$isButtonVisible.animation(.linear(duration: 2))){
                Text("show/hide btn")
            }
            .padding()
            
            if isButtonVisible{
                Button(action: {}){
                    Text("example btn")
                }
                .font(.largeTitle)
                .transition(.slide)
            }        
        }
        
        
    }
}
```

### 전환 결합
- AnyTransition의 인스턴스를 combined(with:) 메소드와 함께 사용하면 전환 효과 결합가능
ex)
```swift
///텍스트가 움직이는 동안 페이딩 효과가 추가될 것
.transition(AnyTransition.opacity.combined(with: .move(edge: .top)))
```
- 코드의 복잡함 제거 및 재사용을 위해 ```AnyTransition 클래스의 extension``` 구현

```swift
extension AnyTransition{
    static var fadeAndMove: AnyTransitin{
        AnyTransition.opacity.combined(with: .move(edge: .top))
    }
}
.
.
.
.transition(.fadeAndMove)
```

### 비대칭 전환
- 디폴트로 SwiftUi는 뷰가 제거될 때/ 나타날 때 지정한 전환을 반대로 하게 됨
> 서로 다른 전환을 지정하려면 비대칭적으로 선언해야 한다
```swift
.transition(.asymmetric(insertion: .scale, removal: .slide))
```