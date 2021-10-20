//
//  Like.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 14.09.2021.
//

import UIKit

class Like {
    
    var isLiked: Bool
    var countLikes: Int
    
    init(_ isLiked: Bool,
         _ countLikes: Int) {
        self.isLiked = isLiked
        self.countLikes = countLikes
    }
}
