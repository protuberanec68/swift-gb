//
//  MeViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.09.2021.
//

import UIKit

class MeViewController: UIViewController {

    var likeView: LikeControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeView = LikeControl(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        likeView.backgroundColor = UIColor.clear
        likeView.center = view.center
        likeView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        view.addSubview(likeView)
        
//        likeView.addTarget(
//            self,
//            action: #selector(presss),
//            for: .valueChanged)
    }
    
//    @objc func presss() {
//        print(321)
//    }
}
