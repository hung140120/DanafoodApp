//
//  ProductConfirmTableViewCell.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/27/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class ProductConfirmTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
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
    
    func updateData(product : ProductObject) {
        displayImage.loadImage(from: product.Image)
        nameLabel.text = product.Name
        self.priceLabel.text = "\(product.Price)"
        amountLabel.text = "\(product.Quantity)"
    }
    
}
