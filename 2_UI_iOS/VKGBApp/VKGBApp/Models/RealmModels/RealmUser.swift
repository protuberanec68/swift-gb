//
//  RealmFriend.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 17.10.2021.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var firstName: String = ""
    @Persisted(indexed: true) var lastName: String = ""
    @Persisted var nickname: String = ""
    @Persisted var photoURL: String = ""
    
//    override class func primaryKey() -> String? {
//        "id"
//    }
//
//    override class func indexedProperties() -> [String] {
//        ["lastName"]
//    }
}

extension RealmUser {
    convenience init(_ user: VKUser) {
        self.init()
        self.id = user.id
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.nickname = user.nickname
        self.photoURL = user.photoURL?.absoluteString ?? ""
    }
}
