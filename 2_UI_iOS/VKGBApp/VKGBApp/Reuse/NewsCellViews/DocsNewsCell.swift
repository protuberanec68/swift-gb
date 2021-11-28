//
//  DocsNewsCell.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 01.11.2021.
//

import UIKit

class DocsNewsCell: UITableViewCell {

    @IBOutlet weak var docImageView: UIImageView!
    @IBOutlet weak var docNameLabel: UILabel!
    @IBOutlet weak var docSizeLadel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(new: VKNew, row: Int){
        let doc = new.docs[new.returnCellsCounter()[row].1]
        docImageView.image = UIImage(systemName: "doc")
        docNameLabel.text = doc.title
        docSizeLadel.text = String(doc.size) + " bytes"
    }
}
