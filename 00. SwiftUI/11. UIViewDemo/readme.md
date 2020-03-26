# UIView & SwiftUI 통합
> MapKit, MKMapView, WebView 클래스와 같은 UI 등은 SwiftUI에 존재하지 않음. 따라서 UIView기반의 컴포넌트를 SwiftUI 뷰 선언부에 쉽게 통합하기 위해 ```UIViewRepresentable``` 프로토콜을 제공

- ```makeUiView()``` : UIView 기반 컴포넌트의 인스턴스를 생성하고 필요한 초기화 작업을 수행한 뒤 반환하는 작업
- ```updateView()``` : UIView 자체를 업데이트해야 하는 변경이 SwiftUI 뷰에서 생길 때마다 호출됨
- (optional) ```dismantleUIView()``` : 뷰를 제거하기 전에 정리 작업을 할 수 있는 기회 제공
- (데이터소스/델리게이트가 필요한 UIKit) 래퍼에 ```Cordinator``` 클래스를 추가하고 ```makeCoordinator()``` 메소드 호출을 통한 뷰 할당

### 정적 컴포넌트
Example) UILabel 뷰 선언 후 사용
```Swift
import SwiftUI

//UIVIewRepresentable 프로토콜 상속
struct MyUILabel: UIViewRepresentable{

    
    var text: String
    //UIKit component config
    func makeUIView(context: UIViewRepresentableContext<MyUILabel>) -> UILabel {
        let myLabel = UILabel()
        myLabel.text = text
        myLabel.textAlignment = .center
        return myLabel
    }
    
    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<MyUILabel>) {
        //contents
    }
}
//Optional
struct MyUILabel_Previews: PreviewProvider {
    static var previews: some View{
        MyUILabel(text: "Hello world")
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            //SwiftUI처럼 사용 가능
            MyUILabel(text:"Hello UIKit")
        }
    }
}
```

### Coordinator (이벤트에 반응하는 뷰)
> Coordinator는 이벤트 처리를 위해 래핑된 UIView 컴포넌트에 필요한 프로토콜과 핸들러 메소드를 구현하는 ```클래스의 형태``` ```UIViewRepresentable``` 프로토콜의 ```makeCoordinator()``` 메소드를 통해 래퍼에 적용

ex) ```UIScrollView```
1. 사용자가 뷰의 맨 위를 넘어서 스크롤 하려 할 때 ```spinning progress indicator```표시, 최신 컨텐츠 뷰를 업데이트 할 수 있는 메소드가 호출 되는 ```UIRefreshControl```를 추가할 수 있다.
2. 뉴스 앱에서 사용자가 최신 뉴스를 다운로드 하려고 사용되는 일반적인 기능
3. 리프레시가 완료되면 ```UIRefreshControl``` 인스턴스의 ```endRefreshing()```메소드를 호출해서 ```progress spinner```제거

-> ```UIRefreshControl```이 실행되었음을 알리고 필요한 작업을 수행하도록 하는 방법이 필요

Example)
```Swift
import SwiftUI

//1)
struct MyScrollView:UIViewRepresentable{
    var text: String
    //UIKit component config
    func makeUIView(context: UIViewRepresentableContext<MyScrollView>) -> UIScrollView {
        let scrollView = UIScrollView()
        //3)코디네이트를 델리게이터로 추가
        scrollView.delegate = context.coordinator
        
        scrollView.refreshControl = UIRefreshControl()
        //4) target 설정
        scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh), for: .valueChanged)
        //label
        let myLabel = UILabel(frame:CGRect(x:0,y:0,width:300,height:50))
        myLabel.text = text
        //add myLabel
        scrollView.addSubview(myLabel)
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        //contents
    }
    
    //2) 현재 UIScrollView 인스턴스를 전달받아 로컬에 저장한다
    //이벤트 처리
    class Coordinator: NSObject, UIScrollViewDelegate{
        var control: MyScrollView
        
        init(_ control: MyScrollView){
            self.control = control
        }
        
        //event
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            //사용자가 현재 스크롤 하는 중
            print("view is. scrolling")
        }
        
        @objc func handleRefresh(sender: UIRefreshControl){
            sender.endRefreshing()
        }
    }
    //5) 메소드 호출을 통한 뷰 할당
    func makeCoordinator() -> Coordinator{
        return Coordinator(self)
    }
    

}

struct CoordinatorView: View {
    var body: some View {
        MyScrollView(text:"UIView in SwiftUI")
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
    }
}

```