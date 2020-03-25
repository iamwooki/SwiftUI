//
//  ContentView.swift
//  ContainerAlignDemo
//
//  Created by HyunWook Hong on 2020/03/20.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(alignment: .center) {
                Text("HStack alignment: .lastTextBaseline")
                HStack(alignment: .lastTextBaseline) {
                    Text("largeTitle").font(.largeTitle)
                    Text("body").font(.body)
                    Text("headline").font(.headline)
                }
                Divider()
                Text("HStack alignment: .oneFive")
                HStack(alignment: .oneFive) {
                    Text("largeTitle").font(.largeTitle)
                    Text("body").font(.body)
                    Text("headline").font(.headline)
                }
                Divider()
                NavigationLink(destination: SecondView()){
                    HStack(alignment:.center){
                        Text("Rectangle screen")
                    }
                }
                //you can show using to only iPad
                NavigationLink(destination: AlignmentTool()){
                    HStack(alignment:.center){
                        Text("(only iPAD)")
                        Text("AlignmentTool screen")
                    }
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

extension VerticalAlignment{
    private enum OneFive: AlignmentID{
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            return context.height / 5
        }
    }
    static let oneFive = VerticalAlignment(OneFive.self)
}
