//
//  SecondView.swift
//  GestureDemo
//
//  Created by HyunWook Hong on 2020/03/25.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    //드래그 제스처를 시작한 위치부터 현재 위치까지의 offset
    @GestureState private var offset: CGSize = .zero
    
    var body: some View {
        let drag = DragGesture()
            .updating($offset) { dragValue, state, transaction in
                state = dragValue.translation
                //dragValue
                /**
                 >> ```DragGesture.value Property```
                 >> - ```location (CGPoint)```: 드래그 제스처의 현재 위치
                 >> - ```predictedEndLocation (CGPoint)``` : 현재의 드래그 속도를 바탕으로 드래그가 멈추게 된다면 예상되는 최종 위치
                 >> - ```predictedEndTranslation (CGSize)``` : 현재의 드래그 속도를 바탕으로 드래그를 멈추게 된다면 예상되는 최종 오프셋
                 >> - ```startLocation (CGPoint)``` : 드래그 제스처가 시작된 위치
                 >> - ```time (Date)``` : 현재 드래그 이벤트가 발생한 타임스탬프
                 >> - ```translation (CGsize)``` : 드래그 제스처를 시작한 위치부터 현재 위치까지의 offset
                 **/
        }
        return Image(systemName: "hand.point.right.fill")
            .font(.largeTitle)
            .offset(offset)
            .gesture(drag)
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
