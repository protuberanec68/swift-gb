//
//  FooterNewsView.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.11.2021.
//

import UIKit

class FooterNewsView: UITableViewHeaderFooterView {
    
    private var likeView = LikeView()
    
    private var repostView = UIView()
    private var repostImageView = UIImageView()
    private var repostCountLabel = UILabel()
    
    private var viewsView = UIView()
    private var viewsImageView = UIImageView()
    private var viewsCountLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(new: VKNew) {
        likeView.translatesAutoresizingMaskIntoConstraints = false
        repostView.translatesAutoresizingMaskIntoConstraints = false
        repostImageView.translatesAutoresizingMaskIntoConstraints = false
        repostCountLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsView.translatesAutoresizingMaskIntoConstraints = false
        viewsImageView.translatesAutoresizingMaskIntoConstraints = false
        viewsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        repostView.addSubview(repostImageView)
        repostView.addSubview(repostCountLabel)
        
        viewsView.addSubview(viewsImageView)
        viewsView.addSubview(viewsCountLabel)
        
        contentView.addSubview(likeView)
        contentView.addSubview(repostView)
        contentView.addSubview(viewsView)
        
        NSLayoutConstraint.activate([
            likeView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20.0),
            likeView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 3.0),
            likeView.heightAnchor.constraint(equalToConstant: 20.0),
            likeView.widthAnchor.constraint(equalToConstant: 100.0),
            repostView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 120.0),
            repostView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 3.0),
            repostView.heightAnchor.constraint(equalToConstant: 20.0),
            repostView.widthAnchor.constraint(equalToConstant: 100.0),
            repostImageView.leadingAnchor.constraint(equalTo: repostView.leadingAnchor),
            repostImageView.topAnchor.constraint(equalTo: repostView.topAnchor),
            repostImageView.heightAnchor.constraint(equalToConstant: 20.0),
            repostImageView.widthAnchor.constraint(equalToConstant: 20.0),
            repostCountLabel.leadingAnchor.constraint(equalTo: repostImageView.trailingAnchor),
            repostCountLabel.topAnchor.constraint(equalTo: repostView.topAnchor),
            repostCountLabel.heightAnchor.constraint(equalToConstant: 20.0),
            repostCountLabel.widthAnchor.constraint(equalToConstant: 80.0),

            viewsView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -3.0),
            viewsView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 3.0),
            viewsView.heightAnchor.constraint(equalToConstant: 20.0),
            viewsView.widthAnchor.constraint(equalToConstant: 100.0),
            viewsImageView.leadingAnchor.constraint(equalTo: viewsView.leadingAnchor),
            viewsImageView.topAnchor.constraint(equalTo: viewsView.topAnchor),
            viewsImageView.heightAnchor.constraint(equalToConstant: 20.0),
            viewsImageView.widthAnchor.constraint(equalToConstant: 20.0),
            viewsCountLabel.leadingAnchor.constraint(equalTo: viewsImageView.trailingAnchor),
            viewsCountLabel.topAnchor.constraint(equalTo: viewsView.topAnchor),
            viewsCountLabel.heightAnchor.constraint(equalToConstant: 20.0),
            viewsCountLabel.widthAnchor.constraint(equalToConstant: 80.0),
        ])
        
        likeView.configure(firstLike: Like(new.isLiked, new.likesCount))
        likeView.backgroundColor = UIColor.clear
        repostImageView.image = UIImage(systemName: "arrowshape.turn.up.forward")
        repostCountLabel.text = String(new.repostsCount)
        viewsImageView.image = UIImage(systemName: "eye")
        viewsCountLabel.text = String(new.viewsCount)
        
    }
    
}
