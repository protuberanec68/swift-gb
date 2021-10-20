//
//  RealmGroup.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 17.10.2021.
//

import Foundation
import RealmSwift

class RealmGroup: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted(indexed: true) var name: String = ""
    @Persisted var isMember: Bool = false
    @Persisted var photoURL: String = ""
    @Persisted var groupDescription: String = ""
    
//    override class func primaryKey() -> String? {
//        "id"
//    }
//
//    override class func indexedProperties() -> [String] {
//        ["name"]
//    }
}

extension RealmGroup {
    convenience init(_ group: VKGroup) {
        self.init()
        self.id = group.id
        self.name = group.name
        self.isMember = group.isMember
        self.photoURL = group.photoURL?.absoluteString ?? ""
        self.groupDescription = group.description
    }
}
