//
//  FotosViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 11.09.2021.
//

import UIKit

class FotosViewController: UIViewController {

    private var fotoView: UIView!
    private var fotoImageView: UIImageView!
    private var likeView: LikeView!
    
    var fotoSet: [Foto] = friendFotos
    var currentFoto: Foto!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentFoto = fotoSet.randomElement()
        
        setFotoView()
        setFotoImageView()
        setLike()

    }

    private func setFotoView(){
        fotoView = UIView()
        fotoView.translatesAutoresizingMaskIntoConstraints = false
        fotoView.backgroundColor = .lightGray
        
        self.view.addSubview(fotoView)
        
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
                multiplier: 1.0)
        ])
    }
    
    private func setFotoImageView(){
        fotoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        fotoImageView.image = currentFoto.foto
        fotoImageView.translatesAutoresizingMaskIntoConstraints = false
        //fotoImageView.bounds = fotoImageView.frame
        fotoImageView.clipsToBounds = true
        fotoImageView.contentMode = .scaleAspectFit
        //fotoImageView.autoresizingMask = .flexibleWidth
        fotoView.addSubview(fotoImageView)

        
        NSLayoutConstraint.activate([
            fotoImageView.topAnchor.constraint(
                equalTo: fotoView.topAnchor,
                constant: -5.0),
            fotoImageView.centerXAnchor.constraint(
                equalTo: fotoView.centerXAnchor,
                constant: 0.0),
            fotoImageView.widthAnchor.constraint(
                equalTo: fotoView.widthAnchor,
                multiplier: 0.9),
            fotoImageView.heightAnchor.constraint(
                equalTo: fotoView.heightAnchor,
                multiplier: 0.9)
        ])
        
        
    }
    
    private func setLike(){
        likeView = LikeView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        likeView.configure(isLiked: currentFoto.isLiked, likeCount: currentFoto.countLikes)
        likeView.backgroundColor = UIColor.clear
        likeView.translatesAutoresizingMaskIntoConstraints = false
        likeView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        fotoView.addSubview(likeView)
        
        NSLayoutConstraint.activate([
            likeView.topAnchor.constraint(
                equalTo: fotoImageView.bottomAnchor,
                constant: 10.0),
            likeView.centerXAnchor.constraint(
                equalTo: fotoView.centerXAnchor,
                constant: 0.0),
        ])

        
    }
    
}
