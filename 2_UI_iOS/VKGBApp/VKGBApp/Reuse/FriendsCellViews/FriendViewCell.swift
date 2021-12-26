//
//  FriendViewCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 29.08.2021.
//

import UIKit
import Nuke

class FriendViewCell: UITableViewCell {

    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var friendNickNameLabel: UILabel!
    @IBOutlet var friendAvatarView: AvatarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(friend: RealmUser) {
        self.friendNameLabel.text = friend.lastName + " " + friend.firstName
        self.friendNickNameLabel.text = friend.nickname
        guard let url = URL(string: friend.photoURL) else {
            self.friendAvatarView.imageView.image = UIImage.defaultImage
            return
        }
        Nuke.loadImage(
            with: url,
            into: self.friendAvatarView.imageView)
    }
    
}
