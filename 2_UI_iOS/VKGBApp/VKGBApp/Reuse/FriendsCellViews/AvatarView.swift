//
//  AvatarView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 09.09.2021.
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
    
    let makeImageSmaller = CABasicAnimation(keyPath: "transform.scale")
    let makeImageBigger = CASpringAnimation(keyPath: "transform.scale")
    
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
        
        makeImageSmaller.fromValue = 1
        makeImageSmaller.toValue = 0.9
        makeImageSmaller.duration = 0.5
        makeImageSmaller.fillMode = .forwards;
        makeImageSmaller.isRemovedOnCompletion = false
        makeImageSmaller.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        makeImageBigger.fromValue = 0.9
        makeImageBigger.toValue = 1
        makeImageBigger.duration = 0.3
        makeImageBigger.damping = 0.1
        makeImageBigger.initialVelocity = 0.5
        makeImageBigger.mass = 3
        makeImageBigger.stiffness = 200
        makeImageBigger.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.layer.add(
            makeImageSmaller,
            forKey: "makeSmaller")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.layer.removeAnimation(forKey: "makeSmaller")
        self.layer.add(
            makeImageBigger,
            forKey: nil)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.layer.removeAnimation(forKey: "makeSmaller")
        self.layer.add(
            makeImageBigger,
            forKey: nil)
    }
    
}
