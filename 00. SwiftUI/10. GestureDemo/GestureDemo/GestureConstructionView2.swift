//
//  GestureConstructionView.swift
//  GestureDemo
//
//  Created by HyunWook Hong on 2020/03/25.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

//[동시적 구성] 롱 프레스와 드래그 제스처를 동시
struct GestureConstructionView2: View {
    @GestureState private var offset: CGSize = .zero
    @GestureState private var longPress: Bool = false
    
    var body: some View {
        
        let longPressAndDrag = LongPressGesture(minimumDuration: 1.0)
            //롱 프레스 진행
            .updating($longPress) { value, state, transition in
                state = value
        }
        //동시에 드래그 진행가능
        .simultaneously(with: DragGesture())
        .updating($offset) { value, state, transaction in
            state = value.second?.translation ?? .zero
        }
        
        return Image(systemName: "hand.point.right.fill")
            .foregroundColor(longPress ? Color.red : Color.blue)
            .font(.largeTitle)
            .offset(offset)
            .gesture(longPressAndDrag)
        
    }
}

struct GestureConstructionView2_Previews: PreviewProvider {
    static var previews: some View {
        GestureConstructionView2()
    }
}
