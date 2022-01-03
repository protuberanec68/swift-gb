//
//  MyGroupsViewCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 10.10.2021.
//

import UIKit
import Nuke

class MyGroupsViewCell: UITableViewCell {
    @IBOutlet var groupImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    private var group = RealmGroup()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(group: RealmGroup) {
        self.group = group
        self.nameLabel.text = self.group.name
        self.detailLabel.text = self.group.groupDescription
        guard let url = URL(string: self.group.photoURL) else {
            self.groupImage.image = UIImage.defaultImage
            return
        }
        Nuke.loadImage(
            with: url,
            into: self.groupImage)
    }
}
