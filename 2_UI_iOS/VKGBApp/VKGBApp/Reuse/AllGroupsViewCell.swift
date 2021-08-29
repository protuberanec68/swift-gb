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
    private var groupID: Int = 0
    private var isGroupMy: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    //addTarget(self, action: #selector(didPress), for: .touchUpInside) {}
    func configure(groupID: Int, group: Group, isGroupMy: Bool) {
        self.groupImage.image = group.image
        self.nameLabel.text = group.name
        self.detailLabel.text = group.details
        self.groupID = groupID
        self.isGroupMy = isGroupMy
        if self.isGroupMy {
            self.actionGroupButton.setTitle("Delete", for: .normal)
            self.actionGroupButton.setTitleColor(.systemRed, for: .normal)
        } else {
            self.actionGroupButton.setTitle("Add", for: .normal)
            self.actionGroupButton.setTitleColor(.systemGreen, for: .normal)
        }
        actionGroupButton.addTarget(
            self,
            action: #selector(didPressed),
            for: .touchUpInside)
    }
    
    @objc private func didPressed() {
        if self.isGroupMy {
            self.actionGroupButton.setTitle("Add", for: .normal)
            self.actionGroupButton.setTitleColor(.systemGreen, for: .normal)
            myGroupsID = myGroupsID.filter { $0 != groupID }
        } else {
            self.actionGroupButton.setTitle("Delete", for: .normal)
            self.actionGroupButton.setTitleColor(.systemRed, for: .normal)
            myGroupsID.append(groupID)
            
        }
        self.isGroupMy.toggle()
        
    }
    
}
