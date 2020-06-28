//
//  CategoryCollectionViewCell.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/3/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateData(prodcutCategory : ProductCategoryObject) {
        imageView.loadImage(from: prodcutCategory.Image)
        nameLabel.text = prodcutCategory.Name
    }

}
