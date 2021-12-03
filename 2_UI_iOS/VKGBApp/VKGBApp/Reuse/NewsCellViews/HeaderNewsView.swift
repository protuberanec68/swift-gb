//
//  HeaderNewsView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.11.2021.
//

import UIKit
import Nuke

class HeaderNewsView: UITableViewHeaderFooterView {
    
    let sourceImage = UIImageView()
    let nameTitle = UILabel()
    let dateTitle = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHeader()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(new: VKNew) {
        nameTitle.text = new.sourceName
        dateTitle.text = new.date.date()
        guard let url = new.photoUrl else {
            return
        }
        Nuke.loadImage(
            with: url,
            into: sourceImage)
    }
    
    func setupHeader() {
        sourceImage.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
        
        sourceImage.layer.cornerRadius = 25.0
        sourceImage.clipsToBounds = true
        
        dateTitle.font = dateTitle.font.withSize(12.0)
        
        sourceImage.backgroundColor = .systemBackground
        sourceImage.isOpaque = true
        nameTitle.backgroundColor = .systemBackground
        nameTitle.isOpaque = true
        dateTitle.backgroundColor = .systemBackground
        dateTitle.isOpaque = true
        
        contentView.addSubview(sourceImage)
        contentView.addSubview(nameTitle)
        contentView.addSubview(dateTitle)
        
        
        NSLayoutConstraint.activate([
            sourceImage.leadingAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            sourceImage.widthAnchor.constraint(equalToConstant: 50.0),
            sourceImage.heightAnchor.constraint(equalToConstant: 50.0),
            sourceImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            nameTitle.heightAnchor.constraint(equalToConstant: 18.0),
            nameTitle.leadingAnchor.constraint(
                equalTo: sourceImage.trailingAnchor,
                constant: 8.0),
            nameTitle.trailingAnchor.constraint(
                equalTo:contentView.layoutMarginsGuide.trailingAnchor),
            nameTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateTitle.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -3.0),
            dateTitle.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -5.0),
            dateTitle.heightAnchor.constraint(equalToConstant: 10.0),
            dateTitle.widthAnchor.constraint(equalToConstant: 100.0)
        ])
    }
    
}
