//
//  SwiftUIView.swift
//  HostingControllerDemo
//
//  Created by HyunWook Hong on 2020/03/27.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
            HStack{
                Image(systemName:"smiley")
                Text("This is a SwiftUI View")
            }
        }
        .font(.largeTitle)
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(text:"Sample Text")
    }
}
