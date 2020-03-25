//
//  ContentView.swift
//  GestureDemo
//
//  Created by HyunWook Hong on 2020/03/25.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var magnification: CGFloat = 1.0
    
    var body: some View {
        let magnificationGesture = MagnificationGesture(minimumScaleDelta: 0)
            .onChanged({value in
                self.magnification = value
            })
            .onEnded({_ in
                print("Gesture Ended")
            })
        
        return NavigationView{
            VStack {
                Image(systemName: "hand.point.right.fill")
                    .resizable()
                    .scaleEffect(magnification)
                    .font(.largeTitle)
                    .gesture(magnificationGesture)
                    .frame(width:100, height:90)
                    .padding()
                
                Divider()
                NavigationLink(destination: SecondView()){
                    Text("@GestureState 사용")
                }
                Divider()
                NavigationLink(destination: GestureConstructionView2()){
                    Text("제스처 복합 구성(동시적 구성)")
                }
                Divider()
                NavigationLink(destination: GestureConstructionView()){
                    Text("제스처 복합 구성(순서적 구성)")
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
