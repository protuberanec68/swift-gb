//
//  CellView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import SwiftUI
import Kingfisher

struct CellView: View {
    let image: URL?
    let firstLine: String
    let secondLine: String
    
    init(
        image: URL?,
        firstLine: String,
        secondLine: String) {
            self.image = image
            self.firstLine = firstLine
            self.secondLine = secondLine
        }
    
    init(user: User) {
        self.image = user.photoURL
        self.firstLine = user.name
        self.secondLine = ""
    }
    
    var body: some View {
        HStack(alignment: .center){
            ImageCellView{
                KFImage(image)
                //Image(uiImage: UIImage(named: image) ?? UIImage(systemName: "face.smiling")!)
                
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
    var content: KFImage
    
    init(@ViewBuilder content: () -> KFImage) {
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
            image: nil,
            firstLine: "Text you want 1",
            secondLine: "Text you want 2ds")
    }
}
