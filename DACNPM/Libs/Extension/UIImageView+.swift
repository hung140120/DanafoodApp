//
//  UIImageView+.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func loadImage(from url: String, cropTo size: CGSize? = nil) {
      guard let url = URL(string: url) else { return }
      if let size = size {
        kf.setImage(with: url, options: [.processor(CroppingImageProcessor(size: size))])
      } else {
        kf.setImage(with: url)
      }
    }
}
