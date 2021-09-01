//
//  FriendViewCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 29.08.2021.
//

import UIKit

//@IBDesignable
class AvatarView: UIView {
    
    var imageView = UIImageView()
    private let shadowView = UIView()
    
    @IBInspectable var shadowRadius: CGFloat = 29.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 29.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowBlur: CGFloat = 3.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var logoHeight: CGFloat = 58.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var logoWigth: CGFloat = 58.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.3 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: -2, height: 3) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        imageView.frame = CGRect(
            x: 5.0,
            y: 0.0,
            width: logoWigth,
            height: logoHeight)
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        
        shadowView.frame = rect
        shadowView.clipsToBounds = false
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowOffset = shadowOffset
        shadowView.layer.shadowRadius = shadowBlur
        shadowView.layer.shadowPath = UIBezierPath(
            roundedRect: shadowView.bounds,
            cornerRadius: shadowRadius).cgPath
        shadowView.backgroundColor = .clear
        
        shadowView.addSubview(imageView)
        self.addSubview(shadowView)
    }
    
}


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
        self.friendNameLabel.text = friend.firstName + " " + friend.lastName
        self.friendNickNameLabel.text = friend.nickName
        self.friendAvatarView.imageView.image = friend.image
    }
    
}
