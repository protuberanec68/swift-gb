//
//  ParsingJSONvkFriends.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 21.11.2021.
//

import Foundation

final class ParsingJSONvkFriends: AsyncOperation {
    
    var friends: [VKUser] = []
    
    override func main() {
        guard let fetchFriendsOperation = dependencies.first as? FetchJSONvkGroups,
              let data = fetchFriendsOperation.data else { return }
        do {
            friends = try JSONDecoder().decode(VKResponse<VKUsers>.self, from: data).response.items
        } catch {
            print(error)
        }
        self.state = .finished
    }
}
