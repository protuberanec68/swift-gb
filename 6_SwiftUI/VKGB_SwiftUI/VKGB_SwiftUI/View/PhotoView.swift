//
//  PhotoView.swift
//  VKGB_SwiftUI
//
//  Created by Игорь Андрианов on 30.01.2022.
//

import SwiftUI
import ASCollectionView

let photos = [Photo(photo: "lamawomen"),
              Photo(photo: "oldman"),
              Photo(photo: "redman"),
              Photo(photo: "parrotman"),
]

struct PhotoView: View {
    var body: some View {
        ASCollectionView(data: photos) { (photo, context) in
            Image(uiImage: UIImage(named: photo.photo) ?? UIImage(named: "default")!)
                .resizable()
            
        }.layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(2),
                itemSpacing: 8,
                lineSpacing: 8)
        }.navigationBarTitle("123333")
        
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
