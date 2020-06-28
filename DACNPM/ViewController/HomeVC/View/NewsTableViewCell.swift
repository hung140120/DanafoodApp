//
//  NewsTableViewCell.swift
//  DACNPM
//
//  Created by Dinh Hung on 5/28/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateData(post : PostObject) {
        imagePost.loadImage(from: post.Image)
        nameLabel.text = post.Name
        descriptionLabel.text = "\(post.Description)"
    }
    
}
