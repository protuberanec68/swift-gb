//
//  LikeView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 11.09.2021.
//

import UIKit

class LikeView: UIView {

    private var countLikesLabel = UILabel()
    var likeHeartView = UIView()
    private var fillColor = UIColor.systemRed
    private var strokeColor = UIColor.systemRed
    private var isLiked = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isLiked = isPostLiked2
        placeLabel(count: likesPostCount2)
        makeHeart()
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didTap(_: )))
        likeHeartView.addGestureRecognizer(tap)
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            print(123)
        }
    }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    func placeLabel(count: Int) {
            countLikesLabel = UILabel(frame: CGRect(x: 20.0, y: 0.0, width: 80.0, height: 20.0))
            countLikesLabel.text = String(count)
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
        
    private func makeHeart() {

        if !isLiked {
            fillColor = UIColor.clear
            strokeColor = UIColor.blue
        }
        
        let layer = CAShapeLayer()
        layer.path = heart().cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
        layer.strokeStart = 0
        layer.strokeEnd = 1
        
        likeHeartView.layer.addSublayer(layer)
        likeHeartView.layer.frame = CGRect(x: 0, y: 0, width: 20.0, height: 20.0)
        likeHeartView.clipsToBounds = false
        
        addSubview(likeHeartView)

        NSLayoutConstraint.activate([
            likeHeartView.centerYAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 0.0),
            likeHeartView.centerXAnchor.constraint(
                equalTo: self.leftAnchor,
                constant: 2.0),
            likeHeartView.widthAnchor.constraint(
                equalTo: likeHeartView.heightAnchor,
                multiplier: 1.0),
            likeHeartView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 1.0) ])
        
    }
}

    
//    let strokeEndAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
//    strokeEndAnimation.fromValue = 0
//    strokeEndAnimation.toValue = 1
//
//    let strokeStartAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeStart))
//    strokeStartAnimation.fromValue = -0.1
//    strokeStartAnimation.toValue = 0.9
//
//    let animationGroup = CAAnimationGroup()
//    animationGroup.duration = 2
//    animationGroup.repeatCount = .infinity
//    animationGroup.animations = [
//        strokeEndAnimation,
//        strokeStartAnimation,
//    ]
//
//    layer.add(animationGroup, forKey: nil)


// .indentity
