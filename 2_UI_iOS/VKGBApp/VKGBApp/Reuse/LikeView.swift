//
//  LikeView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.09.2021.
//

import UIKit

class LikeView: UIView {

    private var countLikesLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawHeart(on: self)
        placeLabel(on: self)
    }

    func drawHeart(on view: UIView) {
        let context = CAShapeLayer()
        setColorHeart(isLiked: isPostLiked, context: context)
        context.backgroundColor = UIColor.clear.cgColor
        context.lineWidth = 2.0
        context.path = heartBezier().cgPath
        view.layer.addSublayer(context)
    }
    
    func placeLabel(on view: UIView) {
        countLikesLabel = UILabel(frame: CGRect(x: 20.0, y: 0.0, width: 80.0, height: 20.0))
        countLikesLabel.text = String(likesPostCount)
        countLikesLabel.backgroundColor = .clear
        countLikesLabel.textColor = .black
        
        view.addSubview(countLikesLabel)
        
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
    
    func heartBezier() -> UIBezierPath {
        let heart = UIBezierPath()
        heart.move(to: CGPoint(x: 16.0, y: 7.0))
        heart.addLine(to: CGPoint(x: 8.0, y: 16.0))
        heart.addLine(to: CGPoint(x: 0.0, y: 7.0))

        heart.addArc(
            withCenter: CGPoint(x: 4.0, y: 7.0),
            radius: 4,
            startAngle: .pi,
            endAngle: 0,
            clockwise: true)
        heart.addArc(
            withCenter: CGPoint(x: 12.0, y: 7.0),
            radius: 4,
            startAngle: .pi,
            endAngle: 0,
            clockwise: true)
        heart.close()
        return heart
    }
    
    func setColorHeart(isLiked: Bool, context: CAShapeLayer) {
        if isLiked {
            context.fillColor = UIColor.systemRed.cgColor
            context.strokeColor = UIColor.systemRed.cgColor
        } else {
            context.fillColor = UIColor.clear.cgColor
            context.strokeColor = UIColor.systemBlue.cgColor
        }
    }
}
