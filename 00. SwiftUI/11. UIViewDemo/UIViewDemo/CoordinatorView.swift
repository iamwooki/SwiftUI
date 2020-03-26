//
//  CoordinatorView.swift
//  UIViewDemo
//
//  Created by HyunWook Hong on 2020/03/27.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct MyScrollView:UIViewRepresentable{
    var text: String
    //UIKit component config
    func makeUIView(context: UIViewRepresentableContext<MyScrollView>) -> UIScrollView {
        let scrollView = UIScrollView()
        //코디네이트를 델리게이터로 추가
        scrollView.delegate = context.coordinator
        
        scrollView.refreshControl = UIRefreshControl()
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
    
    //현재 UIScrollView 인스턴스를 전달받아 로컬에 저장한다
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
