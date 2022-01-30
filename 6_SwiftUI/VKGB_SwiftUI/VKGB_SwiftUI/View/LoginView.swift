//
//  LoginView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 21.01.2022.
//

import SwiftUI

struct LoginView: View {
    
    @State private var login = ""
    @State private var password = ""
    @State private var isAlertPresented = false
    @Binding private var presentMainScreen: Bool
    
    private let myLogin = "1"
    private let myPassword = "1"
    
    init(presentMainScreen: Binding<Bool>){
        self._presentMainScreen = presentMainScreen
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Image("back")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                
                ScrollView{
                    VStack{
                        Text("VKBGClient")
                            .padding(.top, 50.0)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                        Text("Login")
                            .padding(.top, 50.0)
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        TextField(                            "Email address", text: $login)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .keyboardType(UIKeyboardType.emailAddress)
                            .frame(maxWidth: 200)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("Password")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        SecureField(
                            "Password", text: $password
                        ) {
                            print("Enter tapped on password field")
                        }
                        .frame(maxWidth: 200)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: { checkLoginPassword() }) {
                            Text("Log in")
                                .font(.title)
                                .foregroundColor(.green)
                            
                        }
                        .padding(.top, 30.0)
                        .disabled(login.isEmpty || password.isEmpty)
                        
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text("Ошибка"),
                message: Text("Пара логин/пароль не верны. Логин и пароль это '1'"))
        }
    }
    
    //MARK: login func
    private func checkLoginPassword() {
        if myLogin == login, myPassword == password {
            presentMainScreen = true
        } else {
            isAlertPresented = true
        }
    }
    
}

//MARK: hideKeyboard
extension UIApplication {
    func hideKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(presentMainScreen: .constant(false))
            .previewDevice("iPhone 12")
.previewInterfaceOrientation(.portrait)
    }
}
