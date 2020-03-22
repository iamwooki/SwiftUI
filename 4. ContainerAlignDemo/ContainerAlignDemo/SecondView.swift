//
//  SecondView.swift
//  ContainerAlignDemo
//
//  Created by HyunWook Hong on 2020/03/22.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        VStack(alignment: .leading){
            Rectangle().foregroundColor(.green).frame(width:120,height:50)
                .alignmentGuide(.leading, computeValue: { d in d[HorizontalAlignment.trailing]+20 } )
            Rectangle().foregroundColor(.red).frame(width:200,height:50)
                .alignmentGuide(.leading, computeValue: { d in 120.0} )
            Rectangle().foregroundColor(.blue).frame(width:120,height:50)
                .alignmentGuide(.leading, computeValue: { d in d.width / 3} )
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
