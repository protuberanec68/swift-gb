//
//  FriendViewCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 29.08.2021.
//

import UIKit

class AvatarView: UIView {
    
    var logoView = UIImageView()
    let shadowView = UIView()
    
    @IBInspectable var shadowRadius: CGFloat = 125.0
    
    @IBInspectable var shadowBlur: CGFloat = 6.0
    
    @IBInspectable var logoHeight: CGFloat = 250.0
    
    @IBInspectable var logoWigth: CGFloat = 250.0
    
    @IBInspectable var shadowOpacity: Float = 0.3
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 5)
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        logoView.frame = CGRect(x: 0.0, y: 0.0, width: logoWigth, height: logoHeight)
        //logoView.backgroundColor = .systemRed
        logoView.layer.cornerRadius =  shadowRadius
        logoView.clipsToBounds = true
        logoView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        logoView.image = UIImage(named: "default")
        
        shadowView.frame = rect
        shadowView.clipsToBounds = false
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowOffset = shadowOffset
        shadowView.layer.shadowRadius = shadowBlur
        shadowView.layer.shadowPath = UIBezierPath(
            roundedRect: shadowView.bounds,
            cornerRadius: shadowRadius).cgPath
        
        shadowView.addSubview(logoView)
        self.addSubview(shadowView)
    }
    
}


class FriendViewCell: UITableViewCell {

    @IBOutlet var friendAvatarImage: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var friendNickNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(friend: User) {
        self.friendNameLabel.text = friend.firstName + " " + friend.lastName
        self.friendNickNameLabel.text = friend.nickName
        self.friendAvatarImage.image = friend.image

    }
    
}
