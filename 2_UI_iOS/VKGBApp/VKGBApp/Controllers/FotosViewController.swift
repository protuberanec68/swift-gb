//
//  FotosViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 11.09.2021.
//

import UIKit

class FotosViewController: UIViewController {

    private var fotoView: FotoView!
    private var nextFotoView: FotoView!

    var fotoSet: [Foto] = [Foto(defaultFoto, false, 0)]
    var currentFotoIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        fotoView = FotoView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nextFotoView = FotoView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        fotoView.configure(foto: fotoSet[currentFotoIndex])
        nextFotoView.configure(foto: fotoSet[0])
        
        self.view.addSubview(nextFotoView)
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
                multiplier: 1.0),
            nextFotoView.centerYAnchor.constraint(
                equalTo: self.view.centerYAnchor,
                constant: 0.0),
            nextFotoView.leadingAnchor.constraint(
                equalTo: self.view.trailingAnchor,
                constant: 0.0),
            nextFotoView.widthAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.widthAnchor,
                multiplier: 1.0),
            nextFotoView.heightAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.heightAnchor,
                multiplier: 1.0)
        ])
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var shouldAutorotate: Bool {
        return true
    }
}
