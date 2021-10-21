//
//  VKUser.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 09.10.2021.
//

import UIKit

struct VKUsers: Decodable {
    var items: [VKUser]
}

struct VKUser {
    let id: Int
    let firstName: String
    let lastName: String
    let nickname: String
    let photoURL: URL?
}

extension VKUser: Decodable {
    enum CodingKeys: String, CodingKey{
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname
        case photo = "photo_50"
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
        if container.contains(.nickname) {
            self.nickname = try container.decode(
                String.self,
                forKey: .nickname)
        } else {
            self.nickname = ""
        }
        let url = try container.decode(
            String.self,
            forKey: .photo)
        self.photoURL = URL(string: url)
    }
}

/* 
 friends.get
 {
     "response": {
         "count": 3,
         "items": [
             {
                 "first_name": "Alexey",
                 "id": 677567003,
                 "last_name": "Shinkarev",
                 "can_access_closed": true,
                 "is_closed": false,
                 "nickname": "",
                 "track_code": "329a5780km9ojxE08LX231EfhzW1yWZL98Qm8uEYxEfUmb_KX8T_BGa4ezemu_KIZrRHngKjFV_uyDGchQ"
             },
             {
                 "first_name": "Ivan",
                 "id": 677589579,
                 "last_name": "Ivanov",
                 "can_access_closed": true,
                 "is_closed": false,
                 "nickname": "",
                 "track_code": "52846c5cgqWeuz5RNuXEp_aJ-8rbxnhRBOoG8I16XTUq97OmlcnvzpCKA1U35cL8zic8a2ysC0Ud5hGe6Q"
             },
             {
                 "first_name": "Ivanov",
                 "id": 677504579,
                 "last_name": "Ivan",
                 "can_access_closed": true,
                 "is_closed": false,
                 "nickname": "",
                 "track_code": "1d1ebc411XwD7IT36YqPYWl6nJPc4rjvFUuab4tIa-nkMOO7kde4F1-O6fa7249nX9RbMmuIy_sMR40B7w"
             }
         ]
     }
 }
 */
