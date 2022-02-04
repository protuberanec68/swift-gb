//
//  User.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import Foundation

struct User: Identifiable {
    let id: UUID = UUID()
    //let id: Int
    let firstName: String
    let lastName: String
    let name: String
    let photo: String
    //let photoURL: URL?
    
    init(_ firstName: String,
         _ lastName: String,
         _ photo: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.name = self.firstName + " " + self.lastName
        if photo == nil {
            self.photo = "default"
        } else {
            self.photo = photo!
        }
    }
}
