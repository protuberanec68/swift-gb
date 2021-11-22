//
//  SaveRealmVKFriends.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 21.11.2021.
//

import Foundation

final class SaveRealmVKFriends: AsyncOperation {
    
    override func main() {
        guard let parsingFriendsOperation = dependencies.first as? ParsingJSONvkFriends else { return }
        let vkUsers = parsingFriendsOperation.friends
        DispatchQueue.main.async {
            let friends = vkUsers.map { RealmUser($0) }
            do {
                let myFriendsID = friends.map {$0.id}
                let notMyFirendsID = try RealmService.load(typeOf: RealmUser.self).filter(NSPredicate(format: "NOT (id IN %@)", myFriendsID))
                
                try RealmService.delete(object: notMyFirendsID)
                try RealmService.save(items: friends)
            } catch {
                print(error)
            }
            self.state = .finished
        }
    }
}
