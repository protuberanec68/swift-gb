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
    
    private let likeFillColor = UIColor.systemRed
    private let likeStrokeColor = UIColor.systemRed
    private let unlikeFillColor = UIColor.clear
    private let unlikeStrokeColor = UIColor.systemBlue
    
    private var fillColor: UIColor!
    private var strokeColor: UIColor!
    private var heartLayer: CAShapeLayer!
    
    private var likeCount = 0 {
        didSet {
            likesPostCount2 = likeCount
        }
    }
    private var isLiked = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        likeCount = likesPostCount2
        isLiked = isPostLiked2
        if !isLiked {
            fillColor = unlikeFillColor
            strokeColor = unlikeStrokeColor
        }
        placeLabel(count: likeCount)
        makeHeart()
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didTap(_: )))
        likeHeartView.addGestureRecognizer(tap)
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if isLiked {
                likeCount -= 1
            } else {
                likeCount += 1
            }
            isLiked.toggle()
            heartAnimation(set: isLiked)
            countLikesLabel.text = String(likeCount)
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
        heartLayer = CAShapeLayer()
        heartLayer.path = heart().cgPath
        heartLayer.strokeColor = strokeColor.cgColor
        heartLayer.fillColor = fillColor.cgColor
        heartLayer.strokeStart = 0
        heartLayer.strokeEnd = 1
        
        likeHeartView.layer.addSublayer(heartLayer)
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
    
    func heartAnimation(set isLiked: Bool){
        let oldFillColor = fillColor
        let oldStrokeColor = strokeColor
        if isLiked {
            fillColor = likeFillColor
            strokeColor = likeStrokeColor
        } else {
            fillColor = unlikeFillColor
            strokeColor = unlikeStrokeColor
        }
        let animationStroke = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeColor))
        animationStroke.fromValue = oldStrokeColor
        animationStroke.toValue = strokeColor.cgColor
        animationStroke.duration = 0.4
        animationStroke.isRemovedOnCompletion = false
        animationStroke.fillMode = .both
        
        
        let animationFill = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.fillColor))
        animationFill.fromValue = oldFillColor
        animationFill.toValue = fillColor.cgColor
        animationFill.beginTime = CACurrentMediaTime() + 0.3
        animationFill.duration = 0.4
        animationFill.isRemovedOnCompletion = false
        animationFill.fillMode = .both
        
        heartLayer.add(animationFill, forKey: nil)
        heartLayer.add(animationStroke, forKey: nil)
    }
}
