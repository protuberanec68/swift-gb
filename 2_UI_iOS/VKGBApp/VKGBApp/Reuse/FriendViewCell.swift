//
//  FriendViewCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 29.08.2021.
//

import UIKit

class FriendViewCell: UITableViewCell {

    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var friendNickNameLabel: UILabel!
    @IBOutlet var friendAvatarView: AvatarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(friend: User) {
        self.friendNameLabel.text = friend.lastName + " " + friend.firstName
        self.friendNickNameLabel.text = friend.nickName
        self.friendAvatarView.imageView.image = friend.image
    }
    
}
