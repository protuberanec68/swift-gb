//
//  MainView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import SwiftUI

struct MainView: View {
    let usersModel = UsersModel()
    
    var body: some View {
        TabView{
            NavigationView{
                UsersView(usersModel: usersModel)
                    .navigationBarTitle(Text("Мои Друзья"), displayMode: .inline)
            }
            .tabItem{
                Image(systemName: "person.2.fill")
                
                Text("Друзья")
                
            }
            
            NavigationView{
                Text("Здесь будут Группы")
                    .navigationBarTitle(Text("Мои Группы"), displayMode: .inline)
            }
            .tabItem{
                Image(systemName: "book.fill")
                
                Text("Группы")
                
            }
            
            NavigationView{
                Text("Здесь будут Новости")
                    .navigationBarTitle(Text("Мои Новости"), displayMode: .inline)
            }
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
