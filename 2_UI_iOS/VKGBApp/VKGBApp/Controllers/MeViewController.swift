//
//  MeViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.09.2021.
//

import UIKit

class MeViewController: UIViewController {

    var likeView: LikeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeView = LikeView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        likeView.backgroundColor = UIColor.clear
        likeView.layer.borderWidth = 1.0
        likeView.layer.borderColor = UIColor.black.cgColor
        likeView.center = view.center
        likeView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        view.addSubview(likeView)
    }
}
