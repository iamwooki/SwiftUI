# Context Menu
- 사용자가 롱 프레스(long press)를 했을 때 나타나는 메뉴
- (Button View) 각 메뉴 항목은 일반적으로 Text view, image view(optional)로 구성됨
- 모든 View 타입에 추가될 수 있음, contextMenu() 수정자로 구현

```Swift
struct ContentView: View {
    @State private var foregroundColor: Color = Color.black
    @State private var backgroundColor: Color = Color.white
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .padding()
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            //context menu 추가
            .contextMenu{
                Button(action: {
                    self.foregroundColor = .black
                    self.backgroundColor = .white
                }) {
                    Text("Normal Colors")
                    Image(systemName: "paintbrush")
                }
                
                Button(action:{
                    self.foregroundColor = .white
                    self.backgroundColor = .black
                }) {
                    Text("inverted Colors")
                    Image(systemName: "paintbrush.fill")
                }
        }
        
    }
}
```