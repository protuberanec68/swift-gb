//
//  FotosViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 11.09.2021.
//

import UIKit
import RealmSwift

class FotosViewController: UIViewController {

    private var fotoView: FotoView!
    private var animatorRight: UIViewPropertyAnimator!
    private var animatorLeft: UIViewPropertyAnimator!
    private var returnAnimator: UIViewPropertyAnimator!
    private var finish1Animator: UIViewPropertyAnimator!
    private var finish2Animator: UIViewPropertyAnimator!
    private var viewVidth: CGFloat!

    var fotoSet: Results<RealmPhoto>!
    var currentUserID = 0
    var currentFotoIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        fotoView = FotoView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        fotoView.configure(firstFoto: fotoSet[currentFotoIndex])
        self.view.addSubview(fotoView)
        
        let panGestRec = UIPanGestureRecognizer(
            target: self,
            action: #selector(didPan(_:)))
        
        fotoView.isUserInteractionEnabled = true
        fotoView.addGestureRecognizer(panGestRec)
        
        
        NSLayoutConstraint.activate([
            fotoView.centerYAnchor.constraint(
                equalTo: self.view.centerYAnchor,
                constant: 0.0),
            fotoView.centerXAnchor.constraint(
                equalTo: self.view.centerXAnchor,
                constant: 0.0),
            fotoView.widthAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.widthAnchor,
                multiplier: 1.0),
            fotoView.heightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.heightAnchor,
                multiplier: 1.0),
        ])
        
        viewVidth = self.view.frame.size.width
    }
    
    @objc
    private func didPan(_ gesture: UIPanGestureRecognizer){

        switch gesture.state {
        case .began:
            animatorRight = UIViewPropertyAnimator(
                duration: 1,
                curve: .easeInOut,
                animations: {
                    let transform = CGAffineTransform(translationX: self.view.frame.size.width, y: 0.0)
                    self.fotoView.transform = transform
                    //self.nextFotoView.transform = transform
                })
            animatorLeft = UIViewPropertyAnimator(
                duration: 1,
                curve: .easeInOut,
                animations: {
                    let transform = CGAffineTransform(translationX: -self.view.frame.size.width, y: 0.0)
                    self.fotoView.transform = transform
                })
            
            animatorRight.pauseAnimation()
            animatorLeft.pauseAnimation()
            
        case .changed:
            let translation = gesture.translation(in: self.view)
            if translation.x > 0 {
                animatorRight?.fractionComplete = translation.x / 100
            } else {
                animatorLeft?.fractionComplete = -translation.x / 100
            }
            
        case .ended:
            let translation = gesture.translation(in: self.view)
            
            if translation.x > 10.0 {
                animatorLeft?.pauseAnimation()
                animatorLeft?.stopAnimation(false)
                animatorLeft?.finishAnimation(at: .end)
                animatorRight?.continueAnimation(
                    withTimingParameters: nil,
                    durationFactor: 0)
                finish1Animator = UIViewPropertyAnimator(
                    duration: 0.0,
                    curve: .linear,
                    animations: {
                        self.fotoView.alpha = 0.0
                        self.fotoView.transform = .identity
                        if self.currentFotoIndex + 1 < self.fotoSet.count {
                            self.currentFotoIndex += 1
                            self.fotoView.configure(nextFoto: self.fotoSet[self.currentFotoIndex])
                        } else {
                            self.currentFotoIndex = 0
                            self.fotoView.configure(nextFoto: self.fotoSet[self.currentFotoIndex])
                        }
                    })
                finish2Animator = UIViewPropertyAnimator(
                    duration: 0.5,
                    curve: .easeIn,
                    animations: {
                        self.fotoView.alpha = 1.0
                    })

                finish1Animator.startAnimation(afterDelay: 0.5)
                finish2Animator.startAnimation(afterDelay: 0.6)
                
            } else if translation.x < -10.0 {
                animatorRight?.pauseAnimation()
                animatorRight?.stopAnimation(false)
                animatorRight?.finishAnimation(at: .end)
                animatorLeft?.continueAnimation(
                    withTimingParameters: nil,
                    durationFactor: 0)
                finish1Animator = UIViewPropertyAnimator(
                    duration: 0.0,
                    curve: .linear,
                    animations: {
                        self.fotoView.alpha = 0.0
                        self.fotoView.transform = .identity
                        if self.currentFotoIndex - 1 < 0 {
                            self.currentFotoIndex = self.fotoSet.count - 1
                            self.fotoView.configure(nextFoto: self.fotoSet[self.currentFotoIndex])
                        } else {
                            self.currentFotoIndex -= 1
                            self.fotoView.configure(nextFoto: self.fotoSet[self.currentFotoIndex])
                        }
                    })
                finish2Animator = UIViewPropertyAnimator(
                    duration: 0.5,
                    curve: .easeIn,
                    animations: {
                        self.fotoView.alpha = 1.0
                    })

                finish1Animator.startAnimation(afterDelay: 0.3)
                finish2Animator.startAnimation(afterDelay: 0.4)
                
            } else {
                animatorRight?.stopAnimation(true)
                animatorLeft?.stopAnimation(true)
                returnAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                        dampingRatio: 0.5,
                                                        animations: {
                                                            self.fotoView.transform = .identity
                                                        })
                returnAnimator.startAnimation()
            }
        default:
            return
        }
        
        
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
}
