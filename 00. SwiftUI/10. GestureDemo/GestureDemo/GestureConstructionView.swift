//
//  GestureConstructionView.swift
//  GestureDemo
//
//  Created by HyunWook Hong on 2020/03/25.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

//[순서적 구성] 롱 프레스 제스처 완료 후 드래그 작업
struct GestureConstructionView: View {
    @GestureState private var offset: CGSize = .zero
    @State private var dragEnabled: Bool = false
    
    var body: some View {
        
        let longPressBeforeDrag = LongPressGesture(minimumDuration: 2.0)
            .onEnded( { _ in
                //롱 프레스가 끝나면 트리거
                self.dragEnabled = true
            })
            //순차적으로 드래그 작업 시작
        .sequenced(before: DragGesture())
        .updating($offset) { value, state, transaction in
            switch value{
                case .first(true):
                    print("Long press in progress")
                case .second(true, let drag):
                    state = drag?.translation ?? .zero
                    
                default: break
            }
        }
        .onEnded{ value in
            self.dragEnabled = false
        }
        
        return Image(systemName: "hand.point.right.fill")
            .foregroundColor(dragEnabled ? Color.green : Color.blue)
            .font(.largeTitle)
            .offset(offset)
            .gesture(longPressBeforeDrag)
        
    }
}

struct GestureConstructionView_Previews: PreviewProvider {
    static var previews: some View {
        GestureConstructionView()
    }
}
