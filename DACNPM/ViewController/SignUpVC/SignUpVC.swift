//
//  SignUpVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/7/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import RxSwift
import RxCocoa

class SignUpVC: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var arr: [UITextField] = []
    var keyboardhelper:KeyboardHepler!
    var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardhelper = KeyboardHepler(scrollView)
        viewModel = SignUpViewModel()
        viewModel?.delegate = self
        makeUI()
        configBindding()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        viewModel.register(name: nameTextField.string.trim, phone: phoneTextField.string.trim, password: passwordTextField.string.trim,confirmPassword: confirmPassword.string.trim, address: addressTextField.string.trim, email: emailTextField.string.trim, birthday: birthdayTextField.string.trim + "T00:00:00")
        UDKey.User.password.set(passwordTextField.text)
    }
    @IBAction func actionBirthday(_ sender: UITextField) {
        sender.inputView = UIView(frame: CGRect.zero)
        let date:Date = Date(str: "", format: Date.fm_ddmmyyy2, localized: true)
        let doneBlock: ActionDateDoneBlock = { picker, selectedDate, origin in
            if let date = selectedDate as? Date {
                self.birthdayTextField.text = date.toString(format: Date.fm_ddmmyyy2, localized: true)
            }
        }
        let datePicker = ActionSheetDatePicker(title: "Chọn ngày sinh",
                                               datePickerMode: UIDatePicker.Mode.date,
                                               selectedDate: date,
                                               doneBlock:doneBlock,
                                               cancel: nil,
                                               origin: sender)
        datePicker?.toolbarBackgroundColor = UIColor.white
        datePicker?.pickerBackgroundColor = UIColor.white
        datePicker?.setTextColor(UIColor.black)
        datePicker?.show()
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        back()
    }
}

extension SignUpVC: SignUpViewModelDelegate {
    func goto(){
        back()
    }
}

extension SignUpVC {
    func makeUI() {
        emailTextField.setPadding()
        passwordTextField.setPadding()
        phoneTextField.setPadding()
        addressTextField.setPadding()
        nameTextField.setPadding()
        birthdayTextField.setPadding()
        confirmPassword.setPadding()
        arr = [nameTextField,phoneTextField,emailTextField,addressTextField,passwordTextField,birthdayTextField]
        for i in arr {
            i.delegate = self
            i.returnKeyType = .done
        }
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
                //this.signUpButton.stopLoadingAnimation()
            }
            
            if let error = value.error {
                this.alert(error: error)
            }
            
            if value.isValid {
                //                let vc = LoadingVC.vc()
                //                this.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

