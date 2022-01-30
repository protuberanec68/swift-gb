//
//  ContentView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 21.01.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var login = ""
    @State private var password = ""
    
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
                        
                        Button(action: { print("tap button") }) {
                            Text("Log in")
                                .font(.title)
                                .foregroundColor(.green)
                            
                        }
                        .padding(.top, 30.0)
                        .disabled(login.isEmpty || password.isEmpty)
                        
                        CellView(image: "face.smiling", firstLine: "Text you want 1", secondLine: "Text you want 2ds dsdfsdgsf")
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                }
            }
        }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
}



//MARK: CellView
struct CellView: View {
    let image: String
    let firstLine: String
    let secondLine: String
    
    
    var body: some View {
        HStack(alignment: .center){
            ImageCellView() {
                Image(systemName: image)
            }
            VStack(alignment: .leading){
                Text(firstLine)
                    .modifier(TextCellViewModifier(font: .title3, color: .white))
                Text(secondLine)
                    .modifier(TextCellViewModifier(font: .body, color: .white))
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white.opacity(0.1))
    }
}

// MARK: Text ViewModifier
struct TextCellViewModifier: ViewModifier {
    let font: Font
    let color: Color
    
    func body(content: Content) -> some View {
            content
            .font(font)
            .foregroundColor(color)
    }
}

// MARK: Image ViewBuilder
struct ImageCellView: View {
    var content: Image
    
    init(@ViewBuilder content: () -> Image) {
        self.content = content()
    }
    
    var body: some View {
        content
            .resizable()
            .frame(width: 100.0, height: 100.0, alignment: .leading)
            .padding(.leading, 10.0)
    }
}


//MARK: hideKeyboard
extension UIApplication {
    func hideKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
.previewInterfaceOrientation(.portrait)
//        ContentView()
//            .previewDevice("iPad mini (6th generation)")
    }
}
