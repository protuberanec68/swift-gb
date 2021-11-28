//
//  AllGroupsViewCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 26.08.2021.
//

import UIKit
import Nuke

class AllGroupsViewCell: UITableViewCell {
    @IBOutlet var groupImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var actionGroupButton: UIButton!
    private var isGroupMy: Bool = false
    private var group = VKGroup()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(group: VKGroup) {
        self.group = group
        self.nameLabel.text = self.group.name
        self.detailLabel.text = self.group.description
        self.isGroupMy = self.group.isMember
        guard let url = self.group.photoURL else { return }
        Nuke.loadImage(
            with: url,
            into: self.groupImage)
        
        
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
        } else {
            self.actionGroupButton.setTitle("Leave", for: .normal)
            self.actionGroupButton.setTitleColor(.systemRed, for: .normal)
        }
        self.isGroupMy.toggle()
        
    }
    
}
