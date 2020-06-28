//
//  ProceedOrderTableViewCell.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/25/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class ProceedOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var displayImage: UIImageView!
    var listProduct = [ProductObject]()
    var products = ProductObject()
    var amount = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        listProduct = RealmService.shared.getAll(for: ProductObject.self)
        listProduct.map({$0.Quantity}).forEach({ quantity in
            amount = quantity
        })
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
