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
    
    private var like: Like!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(firstLike currentLike: Like){
        self.like = currentLike
        if !like.isLiked {
            fillColor = unlikeFillColor
            strokeColor = unlikeStrokeColor
        } else {
            fillColor = likeFillColor
            strokeColor = likeStrokeColor
        }
        placeLabel(count: like.countLikes)
        makeHeart()
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(didTap(_: )))
        likeHeartView.addGestureRecognizer(tap)
    }
    
    func configure(nextLike newLike: Like){
        self.like = newLike
        self.countLikesLabel.text = String(newLike.countLikes)
        heartAnimation(set: newLike.isLiked)
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            if like.isLiked {
                like.countLikes -= 1
            } else {
                like.countLikes += 1
            }
            like.isLiked.toggle()
            heartAnimation(set: like.isLiked)
            countLikesLabel.text = String(like.countLikes)
        }
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
