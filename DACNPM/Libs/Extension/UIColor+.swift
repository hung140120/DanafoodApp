//
//  UIColor+.swift
//  Car
//
//  Created by Nguyễn Phạm Thiên Bảo on 3/23/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  func getModified(byPercentage percent: CGFloat) -> UIColor? {

    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 0.0

    guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
      return nil
    }

    // Returns the color comprised by percentage r g b values of the original color.
    let colorToReturn = UIColor(displayP3Red: min(red + percent / 100.0, 1.0), green: min(green + percent / 100.0, 1.0), blue: min(blue + percent / 100.0, 1.0), alpha: 1.0)

    return colorToReturn
  }
}
