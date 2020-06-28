//
//  SignUpViewModel.swift
//  XoSo
//
//  Created by Dinh Hung on 4/22/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

protocol SignUpViewModelDelegate: MVVMViewDelegate {
    func goto()
}

class SignUpViewModel: MVVMViewModel {
    
    var dynamicOfNetwork: Dynamic<NetworkResult<Any>> = Dynamic()
    var isHidenPassword = BehaviorRelay<Bool>(value: true)
    var delegate: SignUpViewModelDelegate? = nil
    
    
    init() {
        configBindding()
    }
    
    
    func register(name: String, phone: String, password: String, confirmPassword: String, address : String, email: String, birthday: String) {
        if let error = validate(name: name, phone: phone, password: password, confirmPassword: confirmPassword, address: address, email: email, birthday: birthday) {
            dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: error)
            return
        }
        apiRegister(name: name, phone: phone, password: password, address: address, email: email, birthday: birthday)
    }
}

extension SignUpViewModel {
    fileprivate func validate(name: String, phone: String, password: String, confirmPassword : String, address : String, email: String, birthday: String) -> Error? {
        if name.isEmpty {
            return NSError(message: "Xin vui lòng nhập tên của bạn.")
        }
        
        if (phone.isEmpty) {
            return NSError(message: "Vui lòng nhập số điện thoại.")
        }
        
        if !phone.isPhoneValid {
            return NSError(message: "Số điện thoại không đúng định dạng. Vui lòng nhập lại!")
        }
        
        if email.isEmpty {
            return NSError(message: "Xin vui lòng nhập email.")
        }
        
        if email.isEmailValid {
            return NSError(message: "email không đúng định dạng.")
        }
        
        if address.isEmpty {
            return NSError(message: "Xin vui lòng nhập địa chỉ.")
        }
        
        if password.isEmpty {
            return NSError(message: "Xin vui lòng nhập mật khẩu.")
        }
        
        if !password.isPasswordValid {
            return NSError(message: "Mật khẩu phải có ít nhất 6 ký tự!")
        }
        
        if confirmPassword.isEmpty {
            return NSError(message: "Xin vui lòng nhập xác nhận mật khẩu.")
        }
        
        if confirmPassword != password {
            return NSError(message: "Mật khẩu và xác nhận mật khẩu chưa trùng")
        }
        
        if birthday.isEmpty {
            return NSError(message: "Xin vui lòng nhập ngày sinh.")
        }
        return nil
    }
}

extension SignUpViewModel {
    fileprivate func configBindding() {
        dynamicOfNetwork.bind { [weak self] (value) in
            guard let this = self else { return }
            this.dynamicOfNetwork.value = value
        }
    }
}

extension SignUpViewModel {
    fileprivate func apiRegister(name: String, phone: String, password: String, address : String, email: String, birthday: String) {
        let param = Api.Auth.RegisterParam(name: name,phone: phone, password: password,email: email ,address: address, birthday: birthday)
        dynamicOfNetwork.value = NetworkResult(isLoading: true, data: nil, error: nil)
        Api.Auth.register(param: param) { [weak self] (result) in
            guard let this = self else { return }
            result.isSuccess(completion: { (json) in
                this.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: json, error: nil)
                //guard let data = json as? [String: Any] else { return }
                    //let status = data["status"] as? String else { return }
                self!.apiLoginWithPhone(phone: email, password: password)
            }).error(completion: { (error) in
                let msg = "Email hoặc số điẹn thoại dã dùng"
                let err = NSError(message: msg)
                this.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: err)
            })
        }
    }
    
    
    fileprivate func apiLoginWithPhone(phone: String, password: String) {
        Api.Auth.phoneLogin(phone: phone, password: password, completion: { (result) in
            result.isSuccess(completion: { (json) in
                self.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: json, error: nil)
                guard let data = json as? [String: Any] else { return }
                if data.count != 2 {
                    self.delegate?.goto()
                    let object  = Mapper<UserObject>().map(JSON: data)
                    let token = object?.access_token
                    let userName = object?.Username
                    let email = object?.Email
                    let fullName = object?.Fullname
                    let address = object?.Address
                    let birthday = object?.Birthday
                    let phoneNumber = object?.PhoneNumber
                    //UDKey.User.password.set(object?.Password)
                    UDKey.User.token.set(token)
                    UDKey.User.username.set(userName)
                    UDKey.User.email.set(email)
                    UDKey.User.fullname.set(fullName)
                    UDKey.User.address.set(address)
                    UDKey.User.birthday.set(birthday)
                    UDKey.User.phonenumber.set(phoneNumber)
                } else {
                    let msg = "Mật khẩu hoặc số điẹn thoại k đúng"
                    let err = NSError(message: msg)
                    self.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: err)
                }
            }).error(completion: { (error) in
                print(error)
                self.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: error)
            })
        })
    }
    func actionHidenOrShowPassword() {
        isHidenPassword.accept(!isHidenPassword.value)
    }
    
}
