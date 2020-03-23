//
//  CarData.swift
//  ListNavDemo
//
//  Created by HyunWook Hong on 2020/03/23.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import UIKit
import SwiftUI

//load json file
var carData : [Car] = loadJson("carData.json")

func loadJson<T: Decodable>(_ filename: String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("\(filename) not found.")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch{
        fatalError("Could not load \(filename): (error)")
    }
    
    do{
        return try JSONDecoder().decode(T.self, from: data)
    } catch{
        fatalError("Unable to parse \(filename): (Error)")
    }
}
