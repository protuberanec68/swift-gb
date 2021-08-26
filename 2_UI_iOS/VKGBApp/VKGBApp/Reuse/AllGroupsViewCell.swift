//
//  AllGroupsViewCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 26.08.2021.
//

import UIKit

class AllGroupsViewCell: UITableViewCell {
    @IBOutlet var groupImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var actionGroupButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(group: Group, isMy: Bool) {
        self.groupImage.image = group.image
        self.nameLabel.text = group.name
        self.detailLabel.text = group.details
        if isMy {
            self.actionGroupButton.setTitle("Delete", for: .normal)
            self.actionGroupButton.setTitleColor(.systemRed, for: .normal)
        } else {
            self.actionGroupButton.setTitle("Add", for: .normal)
            self.actionGroupButton.setTitleColor(.systemGreen, for: .normal)
        }
    }
    
}
