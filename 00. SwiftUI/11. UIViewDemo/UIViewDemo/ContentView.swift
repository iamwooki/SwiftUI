//
//  ContentView.swift
//  UIViewDemo
//
//  Created by HyunWook Hong on 2020/03/27.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct MyUILabel: UIViewRepresentable{

    
    var text: String
    //UIKit component config
    func makeUIView(context: UIViewRepresentableContext<MyUILabel>) -> UILabel {
        let myLabel = UILabel(frame:CGRect(x:0,y:0,width:300,height:50))
        myLabel.text = text
        myLabel.textAlignment = .center
        return myLabel
    }
    
    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<MyUILabel>) {
        //contents
    }
}
/*
struct MyUILabel_Previews: PreviewProvider {
    static var previews: some View{
        MyUILabel(text: "Hello world")
    }
}
*/
struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                MyUILabel(text:"Hello UIKit")
                Spacer()
                
                NavigationLink(destination:CoordinatorView()){
                    Text("Move CoordinatorView")
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
