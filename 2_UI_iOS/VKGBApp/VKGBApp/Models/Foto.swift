//
//  Foto.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 12.09.2021.
//

import UIKit

class Foto {
    
    let foto: UIImage
    var like: Like
    
    init(_ foto: UIImage,
         _ isLiked: Bool,
         _ countLikes: Int) {
        self.foto = foto
        self.like = Like(isLiked, countLikes)
    }
}
