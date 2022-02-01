//
//  UsersView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import SwiftUI

struct UsersView: View {
    let users: [User] = [
        User(
            "Заур",
            "порошин",
            nil),
        User(
            "Дмитрий",
            "парошин",
            nil),
        User(
            "Egor",
            "Androniev",
            nil),
        User(
            "Petro",
            "Makarenko",
            "dog"),
        User(
            "Сергей",
            "Петров",
            "soup"),
        User(
            "Алексей",
            "Павлов",
            nil),
        
    ]
    
    let firstCharMaker = FirstCharMaker()
    let preparedUsers = PreparedUsers()
    @State var firstChars: [FirstChar] = []
    @State var dictOfFriends: [FirstChar:[User]] = [:]
    
    var body: some View {
        List(firstChars) { char in
            Section(header: Text(char.id)){
                ForEach(dictOfFriends[char]! ) { user in
                    NavigationLink(destination: PhotoView()) {
                        CellView(user: user)
                        
                    }
                }
            }
            .navigationBarTitle("Мои друзья", displayMode: .inline)
        }
        .onAppear(perform: prepareUsers)
    }
    
    private func prepareUsers(){
        firstCharMaker.prepareFriendsModel(
            from: users,
            to: preparedUsers)
        firstChars = preparedUsers.firstCharsUsersName
        dictOfFriends = preparedUsers.dictOfUsers
        
    }
}
