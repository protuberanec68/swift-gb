//
//  Photo.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import Foundation

class Photo: Identifiable {
    let id = UUID()
    let photo: String
    
    init(photo: String){
        self.photo = photo
    }
}
