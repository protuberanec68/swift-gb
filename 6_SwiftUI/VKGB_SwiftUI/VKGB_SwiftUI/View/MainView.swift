//
//  MainView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            UsersView()
                .tabItem{
                    Image(systemName: "person.2.fill")
                    Text("Друзья")
                }
            
            Text("Здесь будут Группы")
                .tabItem{
                    Image(systemName: "book.fill")
                    Text("Группы")
                }
            
            Text("Здесь будут Новости")
                .tabItem{
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                    Text("Новости")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
