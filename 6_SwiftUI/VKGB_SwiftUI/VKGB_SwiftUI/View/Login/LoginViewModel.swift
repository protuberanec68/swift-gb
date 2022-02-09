//
//  LoginViewModel.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 09.02.2022.
//

import Foundation

class LoginViewModel{
    private let myLogin = "1"
    private let myPassword = "1"
    
    func checkLoginPassword(login: String, password: String) -> Bool {
        return myLogin == login && myPassword == password
    }
}
