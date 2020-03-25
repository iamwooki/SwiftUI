//
//  ContentView.swift
//  DemoProject
//
//  Created by HyunWook Hong on 2020/03/18.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //클로저에 따라 만약 별도의 표현식을 추가하면 Return 구문을 추가해줘야함
        let testString: String = "welcome to  swift"
        
        let carStack = VStack{
            Text("Car img")
                .foregroundColor(.yellow)
            Image(systemName: "car.fill")
            .resizable()
                .aspectRatio(contentMode:.fit)
        }
        
        return VStack{
            
            Text("Hello iOS!!")
                .font(.custom("Copperplate",size:70))
            carStack
            Text("Text1").foregroundColor(.black) + Text("Text2").foregroundColor(.black) + Text(testString).foregroundColor(.red)
            
            VStack{
                Text("sub Vstack1")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .border(Color.black)
                    .padding()
                Text("sub Vstack2")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
                .border(Color.black)
                
                MyHStackView()
                    .font(.largeTitle)
                MyButton()
                
                Button(action:{
                    print("Hello")
                }){
                    Image(systemName: "square.and.arrow.down")
                }
                //View Builder
                MyVStack{
                    Text("text 1")
                    Text("text 2")
                    HStack{
                        Image(systemName: "star.fill")
                        Image(systemName: "star.fill")
                        Image(systemName: "star")
                    }
                }
            }
            
            
        }
        
    }
}

struct MyHStackView: View{
    var body: some View{
        HStack{
            Text("HStack 1")
                .foregroundColor(.blue)
            Text("HStack 2")
            .foregroundColor(.blue)
            Text("Custom")
                .modifier(StandardTitle())
            
        }
    }
}
//event 처리
struct MyButton: View{
    var body: some View{
        Button(action: buttonPressed){
            Text("Click me")
        }
    }
    func buttonPressed(){
        
    }
}
//View Builder 속성 예제
struct MyVStack<Content:View>: View{
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content){
        self.content = content
    }
    var body : some View{
        VStack(spacing:10){
            content()
        }.font(.largeTitle)
    }
}
// 커스텀 수정자
struct StandardTitle: ViewModifier{
    func body(content:Content) -> some View {
        content
            .font(.largeTitle)
            .background(Color.white)
            .border(Color.gray, width:0.2)
            .shadow(color:Color.black, radius:5, x:0,y:5)
    }
}

//컨텐츠 프리뷰
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView()
            .previewDevice(PreviewDevice(rawValue:"iPhone 11 pro"))
            .previewDisplayName("iPhone 11 pro")
                //dark mode
            .environment(\.colorScheme, .dark)
        }
        
    }
}
