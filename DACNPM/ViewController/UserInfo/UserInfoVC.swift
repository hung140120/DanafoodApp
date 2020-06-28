//
//  UserInfoVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/26/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import CommonCrypto
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

class UserInfoVC: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var fullnameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    var viewModel : UserInfoViewModel!
    var keyboardHepler : KeyboardHepler!
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHepler = KeyboardHepler(self)
        viewModel = UserInfoViewModel()
        fecthData()
        configBindding()
        viewModel?.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func actionBack(_ sender: UIButton) {
        back()
    }
    @IBAction func actionCart(_ sender: UIButton) {
        goto(withStoryboar: "Home", withIndentifier: ProceedOrderVC.reuseIdentifier)
    }
    
    func fecthData() {
        self.userNameTextField.text = UDKey.User.username.value
        self.emailTextField.text = UDKey.User.email.value
        self.fullnameTextField.text = UDKey.User.fullname.value
        self.addressTextField.text = UDKey.User.address.value
        self.birthdayTextField.text = UDKey.User.birthday.value
        self.phoneNumberTextField.text = UDKey.User.phonenumber.value
    }
    
    @IBAction func actionSave(_ sender: UIButton) {
        viewModel.UpdateUser(phone: phoneNumberTextField.string.trim, name: fullnameTextField.string.trim, password: UDKey.User.password.value!, address: addressTextField.string.trim, birthday: birthdayTextField.string.trim)
        back()
    }
    @IBAction func actionEdit(_ sender: UIButton) {
        aletPassword()
        
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
}

extension UserInfoVC: UserInfoViewModelDelegate {
    func goto(){
        back()
    }
}

extension UserInfoVC {
    func aletPassword() {
        let alert = UIAlertController(title: "mật khẩu", message: "Bạn phải nhập mật khẩu để thay đổi", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "mật khẩu"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if textField?.text != UDKey.User.password.value {
                let alert1 = UIAlertController(title: "mật khẩu sai", message: "Bạn nhập mật khẩu không đúng ", preferredStyle: .alert)
                
                alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                    
                }))
                self.present(alert1, animated: true, completion: nil)
            } else {
                self.updateButton()
                self.fullnameTextField.isUserInteractionEnabled = true
                self.addressTextField.isUserInteractionEnabled = true
                self.birthdayTextField.isUserInteractionEnabled = true
                self.phoneNumberTextField.isUserInteractionEnabled = true
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func MD5(string: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
   
    
    func updateButton() {
        saveButton.backgroundColor = .red
        saveButton.isUserInteractionEnabled = true
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
            } else {
                let msg = "Bạn đã cập nhật thành công"
                let err = NSError(message: msg)
                this.alert(error: err)
            }
            
            if value.isValid {
                //                let vc = LoadingVC.vc()
                //                this.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
