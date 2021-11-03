//
//  PhotosNewsCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.11.2021.
//

import UIKit

class PhotosNewsCell: UITableViewCell {

    @IBOutlet weak var photosCollectionView: PhotosCollectionView!
    var new: VKNew? {
        didSet{
            photosCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(new: VKNew){
        self.new = new
        self.photosCollectionView.photos = new.photos
    }
}
