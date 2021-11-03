//
//  TextNewsCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.11.2021.
//

import UIKit

class TextNewsCell: UITableViewCell {

    @IBOutlet weak var textNewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(new: VKNew){
        if new.isShortText == true {
            textNewLabel.text = new.shortText
        } else {
            textNewLabel.text = new.text
        }
    }
}
