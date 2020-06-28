//
//  String+.swift
//  Car
//
//  Created by Nguyễn Phạm Thiên Bảo on 3/23/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
import CommonCrypto

extension String {

  /**This method gets size of a string with a particular font.
   */
      func size(usingFont font: UIFont) -> CGSize {
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.font : font])
        return attributedString.size()
      }
    
    
       func sha1() -> String {
           let data = Data(self.utf8)
           var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
           data.withUnsafeBytes {
               _ = CC_SHA1($0.baseAddress, CC_LONG(data.count), &digest)
           }
           let hexBytes = digest.map { String(format: "%02hhx", $0) }
           return hexBytes.joined()
       }
}
