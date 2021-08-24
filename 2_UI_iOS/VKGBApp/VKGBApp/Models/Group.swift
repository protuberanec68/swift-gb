//
//  Group.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit

struct Group {
    let ID: Int
    let name: String
    let description: String?
    let image: UIImage?
    
    init(_ ID: Int,
         _ name: String,
         _ description: String?,
         _ image: UIImage?) {
        self.ID = ID
        self.name = name
        self.description = description
        if let tempImage = image {
            self.image = tempImage
        } else {
            self.image = UIImage(contentsOfFile: "default")
        }
    }
}
