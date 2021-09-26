//
//  MeViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.09.2021.
//

import UIKit

class MeViewController: UIViewController {

    var likeControl: LikeControl!
    var likeView: LikeView!
    var progressBar: UIView!
    var progressDots: [UIView] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeControl = LikeControl(frame: CGRect(
                                    x: 100,
                                    y: 150,
                                    width: 100,
                                    height: 20))
        likeControl.backgroundColor = UIColor.clear
        likeControl.transform = CGAffineTransform(
            scaleX: 1.5,
            y: 1.5)
        view.addSubview(likeControl)
        
        likeView = LikeView(frame: CGRect(
                                x: 100,
                                y: 150,
                                width: 100,
                                height: 20))
        likeView.configure(firstLike: Like(isPostLiked2, likesPostCount2))
        likeView.backgroundColor = UIColor.clear
        likeView.center = view.center
        view.addSubview(likeView)
        
        progressBar = configureBar(x: 100.0, y: 100.0)
        progressDots = configureDots()
        
        for dot in progressDots {
            progressBar.addSubview(dot)
        }
        
        view.addSubview(progressBar)
    
//        likeView.addTarget(
//            self,
//            action: #selector(presss),
//            for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        var delay = 0.1
        let delayBetweenDots = 0.4
        for dot in progressDots {
            animateDots(dot: dot, delay: delay)
            delay += delayBetweenDots
        }
    }
    
//    @objc func presss() {
//        print(321)
//    }
    
    
    
}
