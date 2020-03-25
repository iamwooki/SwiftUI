//
//  SecondView.swift
//  ObservableDemo
//
//  Created by HyunWook Hong on 2020/03/20.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    
    @EnvironmentObject var timerData : TimerData
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            Text("Timer cnt = \(timerData.timeCount)")
                .font(.headline)
            
            
        }
        .padding()
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView().environmentObject(TimerData())
    }
}
