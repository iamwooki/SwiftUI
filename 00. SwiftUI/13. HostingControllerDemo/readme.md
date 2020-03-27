# UIKit & SwiftUI
### UIHostingController
> UIKit 기반의 프로젝트에 통합될 수 있도록 SwiftUI를 감싸는 것
- SwiftUI를 전체화면으로 처리하거나
- 컨테이너 뷰에 호스팅 컨트롤러를 내장하여 기존 UIKit 화면 레이아웃 내에 개별 컴포넌트로 취급할 수 있음
    - 컨테이너 뷰 : 뷰 컨트롤러가 다른 뷰 컨트롤러의 자식으로 구성되게 함
    - SwiftUI 뷰는 코드나 인터페이스 빌더 스토리보드를 사용하여 UIKit 프로젝트에 통합될 수 있다.


### 가. Storyboard를 활용한 SwiftUI 추가
1. SwiftUI contentView 추가하기
2. 스토리 보드 준비하기
    - 뒤로 갈 수 있도록 뷰 컨트롤러를 내비게이션 컨트롤러에 포함 시켜야 함
    - Editor->Embed In->Navigation Controller
    - segue 시킬 Button 추가하기
3. 호스팅 컨트롤러 추가하기
    - (3-1) 추가시킨 Button을 이용해 segue
    - 연결시킨 segue를 insert Segue action
```Swift
import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    //insert segue action
    @IBSegueAction func showSwiftUIVIew(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text:"Integration One"))
    }
}  
```
4. 컨테이너 뷰에 포함하기 (3-2)
    - 라이브러리 패널에서 Container View를 View Controller에 추가한다
    - 라이브러리 패널에서 Hosing View Controller를 추가하고 segue (Embed 옵션)를 한다.
    - 연결된 segue를 ViewController에 insert Segue action

### 나. 코드로 SwiftUI 추가
```Swift
import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 코드로 SwiftUI 추가
        let swiftUIController = UIHostingController(rootView: SwiftUIView(text:"Integartion Code"))
        
        //현재 뷰 컨트롤러의 자식으로 추가
        addChild(swiftUIController)
        //추가하는 모든 컨스트레인트는 뷰가 레이아웃에 추가될 때 적용되는 자동 컨스트레인트와 충돌하지 않게 됨
        swiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        //UIHostingController의 자식 UIView가 포함하는 뷰 컨트롤러의 하위 뷰로 추가됨
        view.addSubview(swiftUIController.view)
        //화면 중앙 배치(x,y)
        swiftUIController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        swiftUIController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        //호스팅 컨트롤러가 컨테이너 뷰 컨트롤러로 이동되었음을 UIKit에게 알리는 이벤트
        swiftUIController.didMove(toParent: self)
        
        
    }
    @IBSegueAction func showSwiftUIVIew(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text:"Integration One"))
    }
    @IBSegueAction func embedSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: SwiftUIView(text:"Integration Two"))
    }
    

}


```
