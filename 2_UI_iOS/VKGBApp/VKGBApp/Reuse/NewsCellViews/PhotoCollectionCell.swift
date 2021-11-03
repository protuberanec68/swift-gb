//
//  PhotoCollectionCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 03.11.2021.
//

import UIKit
import Nuke

class PhotoCollectionCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(photo: URL?){
        guard let url = photo else {
            photoImageView.image = UIImage(systemName: "scribble")
            return
        }
        Nuke.loadImage(
            with: url,
            into: photoImageView)
    }
    
}
