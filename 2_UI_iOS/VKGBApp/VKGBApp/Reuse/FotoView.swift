//
//  FotoView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 12.09.2021.
//

import UIKit

class FotoView: UIView {

    private var fotoImageView: UIImageView!
    private var likeView: LikeView!
    
    private var currentFoto: Foto!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(foto: Foto){
        self.translatesAutoresizingMaskIntoConstraints = false
        currentFoto = foto
        setFotoImageView(currentFoto)
        setLike(currentFoto)

    }
    
    private func setFotoImageView(_ currentFoto: Foto){
        fotoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        fotoImageView.image = currentFoto.foto
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
    
    private func setLike(_ currentFoto: Foto){
        likeView = LikeView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        likeView.configure(currentFoto.like)
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
