//
//  ViewController.swift
//  HostingControllerDemo
//
//  Created by HyunWook Hong on 2020/03/27.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

