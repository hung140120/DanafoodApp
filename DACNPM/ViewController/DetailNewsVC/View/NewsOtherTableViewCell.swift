//
//  NewsOtherTableViewCell.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/24/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class NewsOtherTableViewCell: UITableViewCell {

    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(post : PostObject) {
        displayImage.loadImage(from: post.Image)
        nameLabel.text = post.Name
        descriptionLabel.text = "\(post.Description)"
    }
    
}
