//
//  ContentView.swift
//  ObservableDemo
//
//  Created by HyunWook Hong on 2020/03/20.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var timerData: TimerData = TimerData() //ObservedObject를 이용하면 객체 참조 전달을 해야함
    @EnvironmentObject var timerData: TimerData
    
    var body: some View {
        
        NavigationView{
            VStack{
                Text("Timer cnt = \(timerData.timeCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                .padding()
                Button(action:resetCount){
                    Text("Reset Counter")
                }
                
                NavigationLink(destination:SecondView()){
                    Text("Next Screen")
                    .padding()
                }
            }
        }
    }
    
    func resetCount(){
        timerData.resetCount()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(TimerData())
    }
}
