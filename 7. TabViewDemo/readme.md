# TabView
- 사용자가 이동할 화면들을 나타내는 하위 뷰들로 구성
- 탭 아이템은 수정자를 사용, 각각의 콘텐트 뷰에 적용되며 Text/Image View로 구성
- 탭 아이템에 태그를 추가하면 프로그램적으로 현재 선택된 탭을 제어할 수 있음
```Swift
struct ContentView: View {
    @State private var selection = 1 

    var body: some View {
        TabView(selection : $selection){ //선택된 탭 화면
            Text("First Content View")
                //하단에 표현되는 탭 아이템
                .tabItem{
                    Image(systemName: "1.circle")
                    Text("Screen one")
                }.tag(1) //tag
            Text("Second Content View")
                .tabItem{
                    Image(systemName: "2.circle")
                    Text("Screen second")
                }.tag(2)
            Text("Third Content View")
                .tabItem{
                    Image(systemName: "3.circle")
                    Text("Screen third")
                }.tag(3)
        }
        .font(.largeTitle)
    }
}

```