//
//  CellView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import SwiftUI

struct CellView: View {
    let image: String
    let firstLine: String
    let secondLine: String
    
    init(
        image: String,
        firstLine: String,
        secondLine: String) {
            self.image = image
            self.firstLine = firstLine
            self.secondLine = secondLine
        }
    
    init(user: User) {
        self.image = user.photo
        self.firstLine = user.name
        self.secondLine = ""
    }
    
    var body: some View {
        HStack(alignment: .center){
            ImageCellView() {
                Image(uiImage: UIImage(named: image) ?? UIImage(systemName: "face.smiling")!)
            }
            VStack(alignment: .leading){
                Text(firstLine)
                    .modifier(TextCellViewModifier(font: .title3, color: .black))
                Text(secondLine)
                    .modifier(TextCellViewModifier(font: .body, color: .black))
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


struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(
            image: "face.smiling",
            firstLine: "Text you want 1",
            secondLine: "Text you want 2ds")
    }
}
