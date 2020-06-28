//
//  UIView+Extensions.swift
//  easteregg
//
//  Created by Vu Xuan Hoa on 9/23/19.
//  Copyright © 2019 Vu Xuan Hoa. All rights reserved.
//

import UIKit

extension UIView {
  
  static var loadNib: UINib {
    return UINib(nibName: "\(self)", bundle: nil)
  }
  
  func loadContentFromNib() {
    guard let contentView = type(of: self).loadNib.instantiate(withOwner: self, options: nil).last as? UIView else {
      return
    }
    
    contentView.frame = self.bounds
    self.addSubview(contentView)
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    self.addConstraints([
      NSLayoutConstraint(item: contentView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: contentView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: contentView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: contentView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
    ])
  }
  
  @IBInspectable var borderWidth : CGFloat {
    set {
      layer.borderWidth = newValue
    }
    
    get {
      return layer.borderWidth
    }
  }
  
  @IBInspectable var borderColor : UIColor {
    set {
      self.layer.borderColor = newValue.cgColor
    }
    
    get {
      return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
    }
  }
  
  @IBInspectable var cornerRadius : CGFloat {
    set {
      self.layer.cornerRadius = newValue
    }
    
    get {
      return layer.cornerRadius
    }
  }
  
  @IBInspectable var isMask : Bool {
    set {
      self.layer.masksToBounds = newValue
    }
    
    get {
      return layer.masksToBounds
    }
  }
  
  @IBInspectable var shadowColor : UIColor {
    set {
      self.layer.shadowColor = newValue.cgColor
    }
    
    get {
      return UIColor(cgColor: self.layer.shadowColor ?? UIColor.clear.cgColor)
    }
  }
  
  @IBInspectable var shadowOffset : CGSize {
    set {
      self.layer.shadowOffset = newValue
    }
    
    get {
      return self.layer.shadowOffset
    }
  }
  
  @IBInspectable var shadowOpacity : CGFloat {
    set {
      self.layer.shadowOpacity = newValue.f
    }
    
    get {
      return self.layer.shadowOpacity.g
    }
  }
  
  @IBInspectable var shadowRadius : CGFloat {
    set {
      self.layer.shadowRadius = newValue
    }
    
    get {
      return self.layer.shadowRadius
    }
  }
  
  @IBInspectable var shouldRasterize : Bool {
    set {
      self.layer.shouldRasterize = newValue
    }
    
    get {
      return self.layer.shouldRasterize
    }
  }
  
  func removeAll() {
    for subUIView in self.subviews as [UIView] {
      subUIView.removeFromSuperview()
    }
  }
  
  public var width: CGFloat {
    get { return self.frame.width }
    set { self.frame.size.width = newValue }
  }
  
  public var height: CGFloat {
    get { return self.frame.height }
    set { self.frame.size.height = newValue }
  }
  
  public var size: CGSize {
    get { return self.frame.size }
    set { self.frame.size = newValue }
  }
  
  public func roundBorder(radius: CGFloat, width: CGFloat = 0, color: CGColor = UIColor.clear.cgColor, corners: UIRectCorner = .allCorners) {
    if corners == .allCorners {
      self.layer.cornerRadius = radius
      self.layer.borderWidth = width
      self.layer.borderColor = color
      self.layer.masksToBounds = true
    } else {
      let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let shapeLayer = CAShapeLayer()
      shapeLayer.frame = bounds
      shapeLayer.path = maskPath.cgPath
      shapeLayer.borderColor = color
      shapeLayer.borderWidth = width
      layer.mask = shapeLayer
    }
  }
  
    
    
  func roundCorners(corners:UIRectCorner, radius: CGFloat) {

      DispatchQueue.main.async {
          let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
          let maskLayer = CAShapeLayer()
          maskLayer.frame = self.bounds
          maskLayer.path = path.cgPath
          self.layer.mask = maskLayer
      }
  }
    
  enum LINE_POSITION {
      case LINE_POSITION_TOP
      case LINE_POSITION_BOTTOM
  }
    
  func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
      let lineView = UIView()
      lineView.backgroundColor = color
      lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
      self.addSubview(lineView)

      let metrics = ["width" : NSNumber(value: width)]
      let views = ["lineView" : lineView]
      self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

      switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
      }
  }
    
  public func makeShadow(opacity: Float = 0.5, radius: CGFloat = 2, height: CGFloat = 3, color: UIColor = .gray, bottom: Bool = true, all: Bool = false) {
      self.layer.shadowOpacity = opacity
      self.layer.shadowRadius = radius
      self.layer.shadowColor = color.cgColor
      if all {
        self.layer.shadowOffset = .zero
      } else {
        let offset = bottom ? CGSize(width: 0, height: height): CGSize(width: height, height: 0)
        self.layer.shadowOffset = offset
      }
      self.layer.masksToBounds = false
  }
}
