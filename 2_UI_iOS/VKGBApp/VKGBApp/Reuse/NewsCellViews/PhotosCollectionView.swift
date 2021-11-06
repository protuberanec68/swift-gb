//
//  PhotosCollectionView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 03.11.2021.
//

import UIKit

class PhotosCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photos: [VKNewsPhoto] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
        self.register(
            UINib(
                nibName: "PhotoCollectionCell",
                bundle: nil),
            forCellWithReuseIdentifier: "photoCell")
        self.isScrollEnabled = false
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionCell else {return UICollectionViewCell()}
        cell.configure(photo: photos[indexPath.row].sizes.first{$0.sizeType == "q" }?.url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let fullCell = CGSize(width: screenWidth - 20.0, height: screenWidth - 20.0)
        let halfCell = CGSize(width: screenWidth/2 - 25.0, height: screenWidth/2 - 25.0)
        
        if photos.count % 2 == 0 {
            return halfCell
        } else if indexPath.row == 0 {
            return fullCell
        } else {
            return halfCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }

}
