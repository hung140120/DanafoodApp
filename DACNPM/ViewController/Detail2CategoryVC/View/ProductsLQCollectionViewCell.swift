//
//  ProductsLQCollectionViewCell.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/4/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class ProductsLQCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(prodcut : ProductObject) {
        imageView.loadImage(from: prodcut.Image)
        nameLabel.text = prodcut.Name
        priceLabel.text = "\(prodcut.Price)"
    }

}
