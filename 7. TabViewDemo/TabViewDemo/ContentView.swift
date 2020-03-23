//
//  ContentView.swift
//  TabViewDemo
//
//  Created by HyunWook Hong on 2020/03/23.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    var body: some View {
        TabView(selection : $selection){
            Text("First Content View")
                .tabItem{
                    Image(systemName: "1.circle")
                    Text("Screen one")
                }.tag(1)
            Text("Second Content View")
                .tabItem{
                    Image(systemName: "2.circle")
                    Text("Screen second")
                }.tag(2)
            Text("Third Content View")
                .tabItem{
                    Image(systemName: "3.circle")
                    Text("Screen third")
                }.tag(3)
        }
        .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
