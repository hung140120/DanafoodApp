//
//  SignInVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/7/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var keyboardhelper:KeyboardHepler!
    var viewModel : SignInViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInViewModel()
        viewModel?.delegate = self
        keyboardhelper = KeyboardHepler(scrollView)
        configBindding()
        makeUI()
        // Do any additional setup after loading the view.
    }
    @IBAction func actionLogin(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.phoneLogin(phone: emailTextField.string.trim, password: passwordTextField.string.trim)
        UDKey.User.password.set(passwordTextField.text)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        back()
    }
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        if let vc = getViewControler(aClass: SignUpVC.self) {
            insert(vc: vc, index: 1)
            back(aClass: SignUpVC.self)
        }
    }
}

extension SignInVC: SignInViewModelDelegate {
    func goto(){
        back()
    }
}

extension SignInVC {
    func makeUI() {
        emailTextField.setPadding()
        passwordTextField.setPadding()
        emailTextField.keyboardType = UIKeyboardType.emailAddress
    }
    
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
                }
                
                if value.isValid {
                    //let vc = LoadingVC.vc()
                    //this.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}
