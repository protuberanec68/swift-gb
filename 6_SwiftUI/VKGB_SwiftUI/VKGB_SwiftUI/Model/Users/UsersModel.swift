//
//  UsersModel.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 03.02.2022.
//

import Foundation

class UsersModel: ObservableObject{
    @Published var users: [User] = []
    let networkService = NetworkService()
    
    func fetchUsers(
        endpoint: VKUsers.init(items: []),
        requestType: "friends.get") {
            [weak self] result in
            switch result {
            case .success(let users):
                let realmFriends = users.items.map { RealmUser($0) }
                DispatchQueue.main.async {
                    try? RealmService.save(items: realmFriends)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    
}
