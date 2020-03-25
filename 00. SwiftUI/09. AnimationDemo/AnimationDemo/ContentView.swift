//
//  ContentView.swift
//  AnimationDemo
//
//  Created by HyunWook Hong on 2020/03/23.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var rotation: Double = 0
    @State private var scale: CGFloat = 1
    @State private var visibility = false
    @State private var isSpinning: Bool = true
    @State private var isButtonVisible: Bool = true
    
    var body: some View {
        VStack{
            Group{
                Button(action: {
                    self.rotation = (self.rotation < 360 ? self.rotation + 60 : 0 )
                    self.scale = (self.scale < 2.8 ? self.scale + 0.3 : 1)
                }) {
                    Text("click to animate")
                        .scaleEffect(scale)
                        .rotationEffect(.degrees(rotation))
                        //.animation(.linear(duration:1))
                        //.animation(.spring(response: 1, dampingFraction: 0.2, blendDuration: 0))
                        .animation(Animation.linear(duration:1).repeatCount(2, autoreverses:false))
                }
                Divider()
                Button(action: { withAnimation(.linear(duration: 2)){
                    self.rotation = (self.rotation < 360 ? self.rotation + 60 : 0)
                    self.scale = (self.scale < 2.8 ? self.scale + 0.3 :1)
                    }
                }) {
                    Text("Coick to animate")
                        .rotationEffect(.init(degrees: rotation))
                    .scaleEffect(scale)
                }
                Divider()
                Toggle(isOn: $visibility.animation(.linear(duration: 0.5))){
                    Text("Toogle Text Views")
                }.padding()
                
                if visibility {
                    Text("hello world").font(.largeTitle)
                }
                
                if !visibility {
                    Text("GoodBye world").font(.largeTitle)
                }
                Divider()
            }
            

            Toggle(isOn:$isButtonVisible.animation(.linear(duration: 2))){
                Text("show/hide btn")
            }
            .padding()
            
            if isButtonVisible{
                Button(action: {}){
                    Text("example btn")
                }
                .font(.largeTitle)
                //.transition(.slide)
                    .transition(.move(edge: .top))
            }
            
            Divider()
            ZStack{
                Circle()
                    .stroke(lineWidth:2)
                    .foregroundColor(.blue)
                    .frame(width:360,  height:360)
                
                Image(systemName : "forward.fill")
                    .font(.largeTitle)
                    .offset(y:-180)
                    .rotationEffect(.degrees(360))
                    .animation(Animation.linear(duration:1).repeatForever(autoreverses:false))
            }
            .onAppear(){
                self.isSpinning.toggle()
            }
            
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
