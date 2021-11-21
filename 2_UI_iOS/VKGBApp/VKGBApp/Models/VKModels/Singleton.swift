//
//  Session.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 28.09.2021.
//

import UIKit

class Singleton {
    static public let instance = Singleton()
    
    private init() {}
    
    var token: String = ""
    var userID: Int = 0
    var myGroupsID: [Int] = []
}
