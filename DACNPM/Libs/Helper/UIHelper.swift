//
//  UIHelper.swift
//  XoSo
//
//  Created by Dinh Hung on 5/8/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import SVProgressHUD

class UIHelper: NSObject {
    class func showLoading1(_ message: String = "Please wait...") {
            OperationQueue.main.addOperation { () in
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
                SVProgressHUD.show(withStatus: message)
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                    hideLoading()
                }
            }
        }
    
    class func showLoading(_ message: String = "Please wait...") {
        OperationQueue.main.addOperation { () in
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
            SVProgressHUD.show(withStatus: message)
//            let when = DispatchTime.now() + 1.5
//            DispatchQueue.main.asyncAfter(deadline: when){
//                hideLoading()
//            }
        }
    }
    
    class func showLoadingResult(_ message: String = "Please wait...") {
        OperationQueue.main.addOperation { () in
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
            SVProgressHUD.show(withStatus: message)
//            let when = DispatchTime.now() + 5
//            DispatchQueue.main.asyncAfter(deadline: when){
//                hideLoading()
//            }
        }
    }
    
    class func hideLoading() {
        OperationQueue.main.addOperation { () in
            SVProgressHUD.dismiss()
        }
    }
}
