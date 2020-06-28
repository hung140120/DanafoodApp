//
//  Reuse.swift
//  VideoBridges
//
//  Created by Nguyễn Phạm Thiên Bảo on 3/4/20.
//  Copyright © 2020 Nguyễn Phạm Thiên Bảo. All rights reserved.
//

import Foundation
import UIKit

protocol ReuseIdentifier {
  static var reuseIdentifier: String { get }
}

extension ReuseIdentifier {
  static var reuseIdentifier: String {
    return String(describing: Self.self)
  }
}

protocol ReuseNib: ReuseIdentifier {
  static var nib: UINib { get }
}

extension ReuseNib {
  static var nib: UINib {
    return UINib(nibName: reuseIdentifier, bundle: nil)
  }
}

extension UIViewController: ReuseIdentifier {}
extension UIView: ReuseNib {}


