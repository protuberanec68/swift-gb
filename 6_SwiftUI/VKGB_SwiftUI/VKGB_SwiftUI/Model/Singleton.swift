//
//  Singleton.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 03.02.2022.
//

import Foundation

class Singleton {
    static let instance = Singleton()
    
    var id = 0
    var token = ""
    
    private init(){}
}




