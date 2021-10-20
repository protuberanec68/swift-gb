//
//  RealmPhoto.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 17.10.2021.
//

import Foundation
import RealmSwift

class RealmPhoto: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted(indexed: true) var ownerID: Int = 0
    @Persisted var isLiked: Bool = false
    @Persisted var countLikes: Int = 0
    @Persisted var photoURL: Map<String, String>
    
//    override class func primaryKey() -> String? {
//        "id"
//    }
//
//    override class func indexedProperties() -> [String] {
//        ["ownerID"]
//    }
}

extension RealmPhoto {
    convenience init(_ photo: VKPhoto) {
        self.init()
        self.id = photo.id
        self.ownerID = photo.ownerID
        self.isLiked = photo.isLiked
        self.countLikes = photo.countLikes
        for size in photo.sizes {
            self.photoURL[size.sizeType] = size.url?.absoluteString
        }
    }
}
