//
//  CarStore.swift
//  ListNavDemo
//
//  Created by HyunWook Hong on 2020/03/23.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI
import Combine

class CarStore: ObservableObject{
    //List뷰를 최신 데이터로 유지하기 위해서 게시된 프로퍼티 포함
    @Published var cars: [Car]
    
    init (cars: [Car]){
        self.cars = cars
    }
}
