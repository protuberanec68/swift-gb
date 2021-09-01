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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
                constant: 25.0),
            countLikesLabel.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: 0.5),
            countLikesLabel.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 0.8) ])
    }
    
    func setupButton(){
        likeButton.layer.frame = CGRect(x: 0, y: 0, width: 20.0, height: 20.0)
        likeButton.setImage(UIImage(named: "unlike"), for: .normal)
        likeButton.setImage(UIImage(named: "like"), for: .selected)
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
                constant: 0.0),
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
    
//    func changeColorHeart(isLiked: Bool, context: CAShapeLayer) {
//        if isLiked {
//            context.fillColor = UIColor.systemRed.cgColor
//            context.strokeColor = UIColor.systemRed.cgColor
//        } else {
//            context.fillColor = UIColor.clear.cgColor
//            context.strokeColor = UIColor.systemBlue.cgColor
//        }
//    }
//
//    func heartBezier() -> UIBezierPath {
//        let heart = UIBezierPath()
//        heart.move(to: CGPoint(x: 16.0, y: 7.0))
//        heart.addLine(to: CGPoint(x: 8.0, y: 16.0))
//        heart.addLine(to: CGPoint(x: 0.0, y: 7.0))
//
//        heart.addArc(
//            withCenter: CGPoint(x: 4.0, y: 7.0),
//            radius: 4,
//            startAngle: .pi,
//            endAngle: 0,
//            clockwise: true)
//        heart.addArc(
//            withCenter: CGPoint(x: 12.0, y: 7.0),
//            radius: 4,
//            startAngle: .pi,
//            endAngle: 0,
//            clockwise: true)
//        heart.close()
//        return heart
//    }
    
    
}
