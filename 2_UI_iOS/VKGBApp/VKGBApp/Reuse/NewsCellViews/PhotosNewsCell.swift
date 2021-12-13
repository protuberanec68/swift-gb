//
//  PhotosNewsCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.11.2021.
//

import UIKit

class PhotosNewsCell: UITableViewCell {

    @IBOutlet weak var photosCollectionView: UICollectionView! {
        didSet {
            photosCollectionView.delegate = self
            photosCollectionView.dataSource = self
        }
    }
    
    var photos: [VKNewsPhoto] = [] {
        didSet {
            photosCollectionView.reloadData()
        }
    }
    
    var new: VKNew? {
        didSet{
            photosCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photosCollectionView.register(
            UINib(
                nibName: "PhotoCollectionCell",
                bundle: nil),
            forCellWithReuseIdentifier: "photoCell")
        photosCollectionView.isScrollEnabled = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(new: VKNew){
        self.new = new
        self.photos = new.photos
    }
}

extension PhotosNewsCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionCell else {return UICollectionViewCell()}
        cell.configure(photo: photos[indexPath.row].sizes.first{$0.sizeType == "q" }?.url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width.rounded()
        let correction = photos[indexPath.row].aspectRatio

        let fullCell = CGSize(
            width: screenWidth - 20.0,
            height: screenWidth * (correction ?? 1.0) - 20.0)
        let halfCell = CGSize(
            width: (screenWidth/2).rounded() - 25.0,
            height: (screenWidth/2).rounded() * (correction ?? 1.0) - 25.0)
        
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
