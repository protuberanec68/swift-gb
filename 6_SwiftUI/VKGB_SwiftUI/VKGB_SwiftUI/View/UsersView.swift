//
//  UsersView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import SwiftUI

struct UsersView: View {
    
    @ObservedObject var usersModel: UsersModel
    
    init(usersModel: UsersModel){
        self.usersModel = usersModel
        UITableView.appearance().sectionFooterHeight = 0
    }
    
    var body: some View {
        List(usersModel.firstChars) { char in
            Section(header: Text(char.id)){
                ForEach(usersModel.dictOfFriends[char]! ) { user in
                    NavigationLink(destination: PhotoView()) {
                        CellView(user: user)
                        
                    }
                }
            }
            .navigationBarTitle("Мои друзья", displayMode: .inline)
            
        }
        .onAppear(perform: usersModel.fetchUsers)
        
    }
}

struct UsersView_Previews: PreviewProvider {
    
    static var previews: some View {
        let usersModel = UsersModel(
            users: [
                User("Sergey",
                     "Petro"),
                User("Сергей",
                     "Петров"),
                User("Алексей",
                     "Павлов"),
            ])
        UsersView(usersModel: usersModel)
            .onAppear(perform: { usersModel.prepareUsers() })
    }
}
