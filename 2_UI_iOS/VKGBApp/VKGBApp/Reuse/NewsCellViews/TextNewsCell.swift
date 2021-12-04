//
//  TextNewsCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.11.2021.
//

import UIKit

class TextNewsCell: UITableViewCell {

    @IBOutlet weak var textNewLabel: UILabel!
    @IBOutlet weak var bottomTextLabelConstraint: NSLayoutConstraint!
    
    var showButton: UIButton!
    var delegate: TableDelegate?
    var new: VKNew!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        if showButton != nil {
            showButton.removeFromSuperview()
        }
    }
    
    //MARK: Old show more/less text
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    func configure(new: VKNew){
        self.new = new
        if self.new.isShortText == nil  {
            textNewLabel.text = self.new.text
        }
        else {
            setShowButton()
            
            if self.new.isShortText! {
                textNewLabel.text = self.new.shortText
                showButton.isSelected = false
            } else {
                textNewLabel.text = self.new.text
                showButton.isSelected = true
            }
        }
    }
    
    func setShowButton() {
        self.showButton = UIButton()
        showButton.translatesAutoresizingMaskIntoConstraints = false
        
        showButton.backgroundColor = .systemBackground
        showButton.isOpaque = true
        showButton.setTitle("Показать весь текст...", for: .normal)
        showButton.setTitle("Скрыть текст...", for: .selected)
        showButton.setTitleColor(.systemBlue, for: .normal)
        showButton.setTitleColor(.systemBlue, for: .selected)
        showButton.contentHorizontalAlignment = .leading
        showButton.titleLabel?.font =
        UIFont(name: "GillSans-SemiBold", size: 17.0)
        
        showButton?.addTarget(
            nil,
            action: #selector(showMoreLessText),
            for: .touchUpInside)
        
        contentView.addSubview(showButton)
        NSLayoutConstraint.activate([
            showButton.leadingAnchor.constraint(
                equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            showButton.widthAnchor.constraint(equalToConstant: 250.0),
            showButton.topAnchor.constraint(equalTo: textNewLabel.bottomAnchor, constant: 2.0),
            showButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 2.0),
        ])
    }
    
    @objc
    func showMoreLessText() {
        showButton?.isSelected.toggle()
        delegate?.reloadTable(cell: self)
    }
}
