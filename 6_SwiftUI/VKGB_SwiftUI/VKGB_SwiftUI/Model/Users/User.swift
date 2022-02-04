//
//  User.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import Foundation

struct Users: Decodable {
    var items: [User]
}

struct User: Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let name: String
    let photoURL: URL?
    
    init(_ firstName: String,
         _ lastName: String) {
        self.id = UUID().hashValue
        self.firstName = firstName
        self.lastName = lastName
        self.name = self.firstName + " " + self.lastName
        self.photoURL = nil
    }
}

extension User: Decodable {
    enum CodingKeys: String, CodingKey{
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(
            Int.self,
            forKey: .id)
        self.firstName = try container.decode(
            String.self,
            forKey: .firstName)
        self.lastName = try container.decode(
            String.self,
            forKey: .lastName)
        self.name = self.firstName + " " + self.lastName
        let url = try container.decode(
            String.self,
            forKey: .photo)
        self.photoURL = URL(string: url)
    }
}
