//
//  Foto.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 12.09.2021.
//

import UIKit

struct Foto {
    
    let foto: UIImage
    let isLiked: Bool
    let countLikes: Int
    
    init(_ foto: UIImage,
         _ isLiked: Bool,
         _ countLikes: Int) {
        self.foto = foto
        self.isLiked = isLiked
        self.countLikes = countLikes
    }
}
