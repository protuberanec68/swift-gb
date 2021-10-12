//
//  FotoView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 12.09.2021.
//

import UIKit
import Nuke

class FotoView: UIView {

    private var fotoImageView: UIImageView!
    private var likeView: LikeView!
    
    private var currentFoto: VKPhoto!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(firstFoto foto: VKPhoto){
        self.translatesAutoresizingMaskIntoConstraints = false
        currentFoto = foto
        setFotoImageView(currentFoto)
        setLike(currentFoto)

    }
    
    func configure(nextFoto newFoto: VKPhoto){
        currentFoto = newFoto
        
        guard let url = currentFoto.sizes.first(where: { $0.sizeType == "y" })?.url else {
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
    
    private func setFotoImageView(_ currentFoto: VKPhoto){
        fotoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        guard let url = currentFoto.sizes.first(where: { $0.sizeType == "y" })?.url else {
            fotoImageView.image = UIImage(named: "default")
            return
        }
        Nuke.loadImage(
            with: url,
            into: fotoImageView)

        fotoImageView.translatesAutoresizingMaskIntoConstraints = false
        //fotoImageView.bounds = fotoImageView.frame
        fotoImageView.clipsToBounds = true
        fotoImageView.contentMode = .scaleAspectFit
        //fotoImageView.autoresizingMask = .flexibleWidth
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
    }
    
    private func setLike(_ currentFoto: VKPhoto){
        likeView = LikeView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        likeView.configure(
            firstLike: Like(
                currentFoto.isLiked,
                currentFoto.countLikes
            )
        )
        likeView.backgroundColor = UIColor.clear
        likeView.translatesAutoresizingMaskIntoConstraints = false
        likeView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.addSubview(likeView)
        
        NSLayoutConstraint.activate([
            likeView.topAnchor.constraint(
                equalTo: fotoImageView.bottomAnchor,
                constant: 10.0),
            likeView.centerXAnchor.constraint(
                equalTo: self.centerXAnchor,
                constant: 0.0),
        ])
    }
    
}
