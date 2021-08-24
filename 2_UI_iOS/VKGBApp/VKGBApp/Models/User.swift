//
//  User.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit

struct User {
    let firstName: String
    let lastName: String
    let nickName: String?
    let image: UIImage?
    
    init(_ firstName: String,
         _ lastName: String,
         _ nickName: String?,
         _ image: UIImage?) {
        self.firstName = firstName
        self.lastName = lastName
        self.nickName = nickName
        if let tempImage = image {
            self.image = tempImage
        } else {
            self.image = UIImage(named: "default")
        }
    }
}
