# observable 객체
- 반복적으로 변하는 데이터 값인 동적데이터를 래핑하는데 사용

# 내비게이션 추가
- 다른 뷰로 이도하도록 ContentView에 내비게이션 링크 추가
```swift
NavigationView{
  VStack{
    //content
  }
  NavigationLink(destination: 다른 뷰이름(){
    Text("Next Screen:)
  }
  .padding()
}
```

# Environment 객체
- 두 개의 뷰 모두가 동일한 객체에 대한 참조체를 전달하지 않아도 접근 가능
```swift
//FirstView.swift, SecondView.swift
struct ContentView: View{
  @EnvironmentObject var timerData: TimerData // Environment 객체 property
  
  var body: some View{
    NavigationView{
    //content
    }
  }
 }
 
 struct ContentView_Previews: PreviewProvder{
   static var previews: some View{
    ContentView().environmentObject( Environment객체() ) //environmentObject( ) 이용
   }
}

//SceneDelegate.siwft
//루트(root)화면이 생성될 때 environment 객체가 추가되도록
func scene(_ scene: UIScene, willConnectTo session ~~~ ){
  let contentView = ContentView()
  //environment 객체
  let timerData = TimerData()
  
  if let windowScene = scene as? UIWindowScene {
    let window =  ~
    //루트에 environmentObject 설정
    window.rootViewController = UIHostingCOntroller(rootView:contentView.environmentObject( timerData ))
    
    self.window = window
    window.makeKeyAndVisible()
  }
}
