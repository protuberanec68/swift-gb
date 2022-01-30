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
            "soup")
    ]
    
    
    var body: some View {
        List(users) { user in
            NavigationLink(destination: PhotoView()) {
                CellView(user: user)
                   }
        }
        .navigationBarTitle("Мои друзья", displayMode: .inline)
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
