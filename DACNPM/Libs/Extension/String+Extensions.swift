//
//  String.swift
//  Car
//
//  Created by Dinh Hung on 1/16/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import Alamofire

func isEmpty(_ obj: Any?) -> Bool {
    if obj == nil {
        return true
    } else if ((obj as? String) != nil) {
        return (obj as? String)!.isEmpty
    }
//    else if ((obj as? Array<Any>) != nil) {
//        return (obj as? Array)!.count == 0
//    }
    else {
        return false
    }
}

extension String {
    var len: Int { return count }
    var host: String? { return (try? asURL())?.host }
    var trim: String { return trimmingCharacters(in: .whitespaces) }
}

extension String {
    var isEmailValid: Bool {
        return range(of: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$", options: .regularExpression) != nil
    }
    
    var isPasswordValid: Bool {
        return range(of: "^[0-9a-zA-Z]{6,}$", options: .regularExpression) != nil
    }
    
    var isPhoneValid: Bool {
        return range(of: "^\\+?1?(\\d{10,12}$)", options: .regularExpression) != nil
    }
}

//extension String {
//    func attribute(att: AttributeObject, replace: String?, with replaceAtt: AttributeObject?) -> NSMutableAttributedString {
//        let tempStr = NSMutableAttributedString()
//        tempStr.append(NSAttributedString(string: self, attributes: att))
//        if let replace = replace, let replaceAtt = replaceAtt {
//            let range = (self as NSString).range(of: replace)
//            tempStr.addAttributes(replaceAtt, range: range)
//        }
//        return tempStr
//    }
//
////    func format(_ arguments: CVarArg...) -> String {
////        return format(getVaList(arguments))
////    }
//
//    func format(_ arguments: CVarArg...) -> String {
//        return NSString(format: self, arguments: getVaList(arguments)) as String
//    }
//
//}

// Barcode
extension String {
    func barcode(barCodeColor: UIColor = UIColor.black, backgroundColor: UIColor = UIColor.white, completion: ((UIImage?) -> Void)?) {
        DispatchQueue.global().async {
            let data = self.data(using: .ascii)
            guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            filter.setValue(data, forKey: "inputMessage")
            
            let filterColor = CIFilter(name: "CIFalseColor")
            filterColor?.setDefaults()
            filterColor?.setValue(filter.outputImage, forKey: "inputImage")
            let qrCodeColor: CIColor = CIColor(cgColor: barCodeColor.cgColor)
            let transparentBackgroundColor: CIColor = CIColor(cgColor: backgroundColor.cgColor)
            filterColor?.setValue(qrCodeColor, forKey: "inputColor0")
            filterColor?.setValue(transparentBackgroundColor, forKey: "inputColor1")
            guard let outputImage = filterColor?.outputImage else {
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            let transform = CGAffineTransform(scaleX: 5.0, y: 5.0)
            let output = outputImage.transformed(by: transform)
            let context = CIContext(options: nil)
            guard let cgImage = context.createCGImage(output, from: output.extent) else {
                DispatchQueue.main.async {
                    completion?(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion?(UIImage(cgImage: cgImage))
            }
        }
    }
}

// Size
extension String {
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}

// Html
extension String {
    var htmlToAttributedString: NSAttributedString? {
        let html = "<font face='Montserrat-Regular' color='#362826' size='4.2'>\(self)</font>"
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
            ]
            let str = try NSAttributedString(data: html.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: options, documentAttributes: nil)
            return str
        } catch {
            print(error)
        }
        return nil
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension String {
    func toJSON() -> Any? {
        let data = self.data(using: .utf8)!
        return data.toJSON()
    }
}

// MARK: String Helper
extension String {
    func urlEncode() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}


