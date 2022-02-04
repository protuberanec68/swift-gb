//
//  ContentView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    private var pub = NotificationCenter.default.publisher(for: NSNotification.Name("vkTokenSaved"))
    
    @State private var presentMainScreen = false
    
    var body: some View {
        NavigationView {
            HStack{
                if !presentMainScreen{
                    VKLoginWebView()
                    
                } else {
                    MainView()
                    
                }

            }
            .navigationBarHidden(true)
            //.navigationTitle(Text("Logout"))
            
        }
        .onReceive(pub){ (output) in
            presentMainScreen = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }
}
