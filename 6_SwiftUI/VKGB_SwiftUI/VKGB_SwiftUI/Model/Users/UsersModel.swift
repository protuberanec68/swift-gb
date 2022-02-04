//
//  UsersModel.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 03.02.2022.
//

import Foundation

class UsersModel: ObservableObject{
    var users: [User] = []
    
    private let networkService = NetworkService()
    private let firstCharMaker = FirstCharMaker()
    let preparedUsers = PreparedUsers()
    
    @Published var firstChars: [FirstChar] = []
    @Published var dictOfFriends: [FirstChar:[User]] = [:]
    
    init() {
    }
    
    init(users: [User]) {
        self.users = users
    }
    
    func fetchUsers(){
        networkService.fetchUsers(from: Singleton.instance.userID) {
                [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let users):
                    self.users = users
                    self.prepareUsers()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func prepareUsers(){
        firstCharMaker.prepareFriendsModel(
            from: users,
            to: preparedUsers)
        firstChars = preparedUsers.firstCharsUsersName
        dictOfFriends = preparedUsers.dictOfUsers
        
    }
}
