//
//  PreparedUsers.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import Foundation

class PreparedUsers {
    var dictOfUsers: [FirstChar : [User]] = [:]
    var firstCharsUsersName: [FirstChar] = []
}

struct FirstChar: Hashable, Identifiable{
    var id: String
}
