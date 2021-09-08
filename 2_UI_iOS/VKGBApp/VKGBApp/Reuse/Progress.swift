//
//  ProgressView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 07.09.2021.
//

import UIKit

let heightBar = 44.0

func configureDots() -> [UIView] {
    var dots: [UIView] = []
    let dotSize = 10.0
    var leadingSpace = -dotSize/2
    let topSpace = heightBar/2 - dotSize/2
    for _ in (0...2) {
        leadingSpace += 25.0
        let dot = UIView(frame: CGRect(
                            x: leadingSpace,
                            y: topSpace,
                            width: dotSize,
                            height: dotSize))
        dot.backgroundColor = .systemGreen
        dot.layer.masksToBounds = true
        dot.layer.cornerRadius = CGFloat(dotSize/2)
        dots.append(dot)
    }
    return dots
}

func configureBar(x: Double, y: Double) -> UIView {
    let bar = UIView(frame: CGRect(
                        x: x,
                        y: y,
                        width: 100,
                        height: heightBar))
    bar.backgroundColor = .white
    bar.layer.borderWidth = 3.0
    bar.layer.borderColor = UIColor.systemGray.cgColor
    bar.layer.masksToBounds = false
    bar.layer.cornerRadius = 5.0
    bar.layer.shadowOpacity = 1.5
    bar.layer.shadowRadius = 5.0
    bar.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    bar.layer.shadowColor = UIColor.black.cgColor
    
    return bar
}

func animateDots(dot: UIView, delay: Double) {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.repeatCount = Float.greatestFiniteMagnitude
    animation.repeatDuration = CFTimeInterval(Float.greatestFiniteMagnitude)
    animation.autoreverses = true
    animation.fromValue = 1
    animation.toValue = 0
    animation.duration = 1
    animation.fillMode = .both
    animation.beginTime = CACurrentMediaTime() + delay
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    dot.layer.add(
        animation,
        forKey: nil)
}
