//
//  ContentView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var presentMainScreen = false
    var body: some View {
        NavigationView {
            HStack{
                LoginView(presentMainScreen: $presentMainScreen)
                
                NavigationLink(
                    isActive: $presentMainScreen,
                    destination: { MainView() },
                    label: { EmptyView() }
                )

            }
            .navigationBarHidden(true)
            .navigationTitle(Text("Logout"))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
.previewInterfaceOrientation(.portrait)
    }
}
