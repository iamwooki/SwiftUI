import UIKit
import PlaygroundSupport

let container = UIView(frame: CGRect(x:0,y:0,width:200,height:200))
PlaygroundPage.current.liveView = container

container.backgroundColor = UIColor.white
let square = UIView(frame:CGRect(x:50,y:50,width: 100,height: 100))
square.backgroundColor = UIColor.red

container.addSubview(square)

//퀵 룩 버튼을 클릭하면 하나씩 코드가 실행되는 단계에 모습을 보여주지만 퀵 룩뷰는 동적인 애니메이션을 보여주지 못한다.
UIView.animate(withDuration: 5.0, animations: {
    square.backgroundColor = UIColor.blue
    let rotation = CGAffineTransform(rotationAngle: 3.14)
    square.transform = rotation
})

print("\(Int32.min) \(Int32.max)")
