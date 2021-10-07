//
//  Session.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 28.09.2021.
//

import UIKit

class Session {
    static public let instance = Session()
    
    private init() {}
    
    var token: String = ""
    var userID: Int = 0
}
