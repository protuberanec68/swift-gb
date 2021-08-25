//
//  Group.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 24.08.2021.
//

import UIKit

struct Group {
    let name: String
    let details: String?
    let image: UIImage?
    
    init(_ name: String,
         _ details: String?,
         _ image: UIImage?) {
        self.name = name
        self.details = details
        if let tempImage = image {
            self.image = tempImage
        } else {
            self.image = UIImage(named: "default")
        }
    }
}
