//
//  FirstCharMaker.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import Foundation

final class FirstCharMaker{
    func prepareFriendsModel(
        from users: [User],
        to usersModel: PreparedUsers) {
            var dictOfUsers: [FirstChar : [User]] = [:]
            users.forEach { user in
                let char = FirstChar(id: String(user.lastName.first!.uppercased()))
                if dictOfUsers[char] == nil {
                    dictOfUsers[char] = []
                }
                dictOfUsers[char]!.append(user)
            }
            usersModel.dictOfUsers = dictOfUsers
            usersModel.firstCharsUsersName = dictOfUsers.keys
                .sorted { $0.id < $1.id }
        }
    
}
