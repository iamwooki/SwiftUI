//
//  ContentView.swift
//  ContextMenuDemo
//
//  Created by HyunWook Hong on 2020/03/23.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var foregroundColor: Color = Color.black
    @State private var backgroundColor: Color = Color.white
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .padding()
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            //context menu 추가
            .contextMenu{
                Button(action: {
                    self.foregroundColor = .black
                    self.backgroundColor = .white
                }) {
                    Text("Normal Colors")
                    Image(systemName: "paintbrush")
                }
                
                Button(action:{
                    self.foregroundColor = .white
                    self.backgroundColor = .black
                }) {
                    Text("inverted Colors")
                    Image(systemName: "paintbrush.fill")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
