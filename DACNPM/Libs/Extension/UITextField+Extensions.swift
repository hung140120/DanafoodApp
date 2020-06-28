//
//  UITextField.swift
//  Car
//
//  Created by Dinh Hung on 1/16/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    var string: String { return text ?? "" }
    
    func setPadding(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    public func roundBottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
