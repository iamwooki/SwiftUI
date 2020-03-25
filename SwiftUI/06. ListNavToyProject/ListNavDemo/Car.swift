//
//  Car.swift
//  ListNavDemo
//
//  Created by HyunWook Hong on 2020/03/23.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI


//json
//Identifiable : ListView에서 식별되도록
struct Car: Codable, Identifiable{
    var id: String
    var name: String
    
    var description: String
    var isHybrid: Bool
    
    var imageName: String
}
