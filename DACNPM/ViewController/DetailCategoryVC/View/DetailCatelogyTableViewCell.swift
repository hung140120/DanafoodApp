//
//  DetailCatelogyTableViewCell.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/4/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class DetailCatelogyTableViewCell: UITableViewCell {

    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(prodcut : ProductObject) {
        displayImage.loadImage(from: prodcut.Image)
        nameLabel.text = prodcut.Name
        priceLabel.text = "\(prodcut.Price)"
    }
    
}
