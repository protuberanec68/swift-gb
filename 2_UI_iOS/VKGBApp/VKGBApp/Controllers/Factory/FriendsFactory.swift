//
//  FriendsFactory.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 26.12.2021.
//

import UIKit
import RealmSwift

struct FriendsModel {
    var dictOfFriends: [String : [RealmUser]] = [:]
    var firstCharsFriendsName: [String] = []
}

final class FriendsFactory{
    
    func prepareFriendsModel(from friends: Results<RealmUser>) -> FriendsModel {
        var friendsModel = FriendsModel()
        var dictOfFriends: [String : [RealmUser]] = [:]
        friends.forEach { friend in
            let char = String(friend.lastName.first!.uppercased())
            if dictOfFriends[char] == nil {
                dictOfFriends[char] = []
            }
            dictOfFriends[char]!.append(friend)
        }
        friendsModel.dictOfFriends = dictOfFriends
        friendsModel.firstCharsFriendsName = dictOfFriends.keys.sorted().map() {$0.uppercased()}
        
        return friendsModel
    }
}
