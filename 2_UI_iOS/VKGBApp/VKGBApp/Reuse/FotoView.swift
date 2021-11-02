//
//  FotoView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 12.09.2021.
//

import UIKit
import Nuke

class FotoView: UIView {

    private var fotoImageView = UIImageView()
    private var likeView = LikeView()
    
    private var currentFoto: RealmPhoto!
    
    func configure(firstFoto foto: RealmPhoto){
        self.translatesAutoresizingMaskIntoConstraints = false
        currentFoto = foto
        setFotoImageView(currentFoto)
        setLike(currentFoto)
    }
    
    func configure(nextFoto newFoto: RealmPhoto){
        currentFoto = newFoto
        
        guard let url = URL(string: currentFoto.photoURL["y"] ?? "") else {
            fotoImageView.image = UIImage(named: "default")
            return
        }
        Nuke.loadImage(
            with: url,
            into: fotoImageView)
        
        likeView.configure(
            nextLike: Like(
                currentFoto.isLiked,
                currentFoto.countLikes
            )
        )
    }
    
    private func setFotoImageView(_ currentFoto: RealmPhoto){
        self.addSubview(fotoImageView)
        
        NSLayoutConstraint.activate([
            fotoImageView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: -5.0),
            fotoImageView.centerXAnchor.constraint(
                equalTo: self.centerXAnchor,
                constant: 0.0),
            fotoImageView.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                multiplier: 0.9),
            fotoImageView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                multiplier: 0.9)
        ])

        fotoImageView.translatesAutoresizingMaskIntoConstraints = false
        fotoImageView.clipsToBounds = true
        fotoImageView.contentMode = .scaleAspectFit
        
        guard let url = URL(string: currentFoto.photoURL["y"] ?? "") else {
            fotoImageView.image = UIImage(named: "default")
            return
        }
        Nuke.loadImage(
            with: url,
            into: fotoImageView)
    }
    
    private func setLike(_ currentFoto: RealmPhoto){
        likeView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(likeView)
        
        NSLayoutConstraint.activate([
            likeView.topAnchor.constraint(
                equalTo: fotoImageView.bottomAnchor,
                constant: 10.0),
            likeView.centerXAnchor.constraint(
                equalTo: self.centerXAnchor,
                constant: 0.0),
            likeView.heightAnchor.constraint(equalToConstant: 20.0),
            likeView.widthAnchor.constraint(equalToConstant: 100.0),
        ])
        
        likeView.configure(
            firstLike: Like(
                currentFoto.isLiked,
                currentFoto.countLikes
            )
        )
        likeView.backgroundColor = UIColor.clear
    }
    
}
