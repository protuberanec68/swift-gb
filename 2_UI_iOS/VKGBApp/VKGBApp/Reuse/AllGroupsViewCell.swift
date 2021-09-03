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
    private var isGroupMy: Bool = false
    private var group = Group("", nil, nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    //addTarget(self, action: #selector(didPress), for: .touchUpInside) {}
    func configure(group: Group) {
        self.group = group
        self.groupImage.image = group.image
        self.nameLabel.text = group.name
        self.detailLabel.text = group.details
        self.isGroupMy = myGroups.contains(group)
        if self.isGroupMy {
            self.actionGroupButton.setTitle("Leave", for: .normal)
            self.actionGroupButton.setTitleColor(.systemRed, for: .normal)
        } else {
            self.actionGroupButton.setTitle("Join", for: .normal)
            self.actionGroupButton.setTitleColor(.systemGreen, for: .normal)
        }
        actionGroupButton.addTarget(
            self,
            action: #selector(didPressed),
            for: .touchUpInside)
    }
    
    @objc private func didPressed() {
        if self.isGroupMy {
            self.actionGroupButton.setTitle("Join", for: .normal)
            self.actionGroupButton.setTitleColor(.systemGreen, for: .normal)
            myGroups = myGroups.filter { $0 != group }
        } else {
            self.actionGroupButton.setTitle("Leave", for: .normal)
            self.actionGroupButton.setTitleColor(.systemRed, for: .normal)
            myGroups.append(group)
            
        }
        self.isGroupMy.toggle()
        
    }
    
}
