//
//  OtherVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/4/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class OtherVC: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerViewLH: UIView!
    @IBOutlet weak var containerViewGT: UIView!
    @IBOutlet weak var viewLH: UIView!
    @IBOutlet weak var topspaceViewLH: NSLayoutConstraint!
    @IBOutlet weak var topSpaceContainerViewLH: NSLayoutConstraint!
    var isTapButtonGT = false
    var isTapButtonLH = false
    var keyboardhelper:KeyboardHepler!
    var viewModel : OtherViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardhelper = KeyboardHepler(scrollView)
        viewModel = OtherViewModel()
        configBindding()
        containerViewGT.isHidden = true
        containerViewLH.isHidden = true
        topspaceViewLH.constant = 40
    }
    @IBAction func actionSend(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.Feedback(name: nameTextField.string.trim, email: emailTextField.string.trim, message: messageTextField.string.trim)
    }
    
    @IBAction func actionCart(_ sender: UIButton) {
        goto(withStoryboar: "Home", withIndentifier: ProceedOrderVC.reuseIdentifier)
    }
    
    @IBAction func actionShowGT(_ sender: UIButton) {
        if isTapButtonGT {
            containerViewGT.isHidden = true
            topspaceViewLH.constant = 40
            topSpaceContainerViewLH.constant = 80
            isTapButtonGT = false
        } else if isTapButtonGT == false {
            containerViewGT.isHidden = false
            topspaceViewLH.constant = 270
            topSpaceContainerViewLH.constant = 310
            isTapButtonGT = true
        }
    }
    
    @IBAction func actionShowLH(_ sender: UIButton) {
        if isTapButtonLH {
            containerViewLH.isHidden = true
            isTapButtonLH = false
        } else if isTapButtonLH == false  && isTapButtonGT == true {
            containerViewLH.isHidden = false
            topSpaceContainerViewLH.constant = 310
            isTapButtonLH = true
        } else if isTapButtonLH == false {
            containerViewLH.isHidden = false
            topSpaceContainerViewLH.constant = 80
            isTapButtonLH = true
        }
    }
}

extension OtherVC {
    fileprivate func configBindding() {
        guard let viewModel = viewModel else { return }
        viewModel.dynamicOfNetwork.bind { [weak self] (value) in
            guard let this = self, let value = value else { return }
            if value.isLoading {
                this.lock()
            }else {
                this.unLock()
                //this.loginButton.stopLoadingAnimation()
                if let error = value.error {
                    this.alert(error: error)
                } else {
                    let msg = "Bạn đã gửi được thông tin"
                    let err = NSError(message: msg)
                    this.alert(error: err)
                }
                
                if value.isValid {
                    //let vc = LoadingVC.vc()
                    //this.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
