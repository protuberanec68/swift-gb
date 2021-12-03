//
//  LikeView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.09.2021.
//

import UIKit

class LikeControl: UIControl {

    private var countLikesLabel = UILabel()
    var likeButton = UIButton()
    var likeImage = UIImage()
    var unlikeImage = UIImage()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareImages()
        placeLabel()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func placeLabel() {
        countLikesLabel = UILabel(frame: CGRect(x: 20.0, y: 0.0, width: 80.0, height: 20.0))
        countLikesLabel.text = String(likesPostCount)
        countLikesLabel.backgroundColor = .clear
        countLikesLabel.textColor = .black
        
        addSubview(countLikesLabel)
        
        NSLayoutConstraint.activate([
            countLikesLabel.centerYAnchor.constraint(
                equalTo: self.centerYAnchor),
            countLikesLabel.centerXAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: 27.0),
            countLikesLabel.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: 0.5),
            countLikesLabel.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 0.8) ])
    }
    
    func setupButton(){
        likeButton.layer.frame = CGRect(x: 0, y: 0, width: 20.0, height: 20.0)
        likeButton.setImage(
            UIImage(cgImage: unlikeImage.cgImage!),
            for: .normal)
        likeButton.setImage(
            UIImage(cgImage: likeImage.cgImage!),
            for: .selected)
        likeButton.isSelected = isPostLiked
        likeButton.clipsToBounds = false
        likeButton.addTarget(
            self,
            action: #selector(changeLike),
            for: .touchUpInside)
        
        addSubview(likeButton)

        NSLayoutConstraint.activate([
            likeButton.centerYAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 0.0),
            likeButton.centerXAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: 2.0),
            likeButton.widthAnchor.constraint(
                equalTo: likeButton.heightAnchor,
                multiplier: 1.0),
            likeButton.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 1.0) ])
    }
    
    @objc func changeLike() {
        if likeButton.isSelected {
            likesPostCount -= 1
        } else {
            likesPostCount += 1
        }
        countLikesLabel.text = String(likesPostCount)
        likeButton.isSelected.toggle()
        sendActions(for: .valueChanged)
    }
    

    private func prepareImages() {
        likeImage = heartBezier(
            fillColor: UIColor.systemRed,
            strokeColor: UIColor.systemRed)
        unlikeImage = heartBezier(
            fillColor: UIColor.white,
            strokeColor: UIColor.systemBlue)
    }
    
    private func heartBezier(fillColor: UIColor, strokeColor: UIColor) -> UIImage {
        let size = CGSize(width: 20.0, height: 20.0)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        
        let heart = heart()
        strokeColor.setStroke()
        heart.stroke()
        fillColor.setFill()
        heart.fill()
        
        context.fillPath()
        context.addPath(heart.cgPath)
        
        guard let img = UIGraphicsGetImageFromCurrentImageContext()
        else { return UIImage() }
        UIGraphicsEndImageContext()
        return img
    }
}
