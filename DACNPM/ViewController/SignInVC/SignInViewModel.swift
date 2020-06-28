//
//  SignInViewModel.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/8/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

protocol SignInViewModelDelegate: MVVMViewDelegate {
    func goto()
}
class SignInViewModel: MVVMViewModel {
    var phoneNumber = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    var isHidenPassword = BehaviorRelay<Bool>(value: true)
    var dynamicOfNetwork: Dynamic<NetworkResult<Any>> = Dynamic()
    var delegate: SignInViewModelDelegate? = nil
    init() {
        configBindding()
    }
    
    func phoneLogin(phone: String, password: String) {
        if let error = validate(phone: phone, password: password) {
            dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: error)
            return
        }
        apiLoginWithPhone(phone: phone, password: password)
    }
}
extension SignInViewModel {
    fileprivate func configBindding() {
        dynamicOfNetwork.bind { [weak self] (value) in
            guard let this = self else { return }
            this.dynamicOfNetwork.value = value
        }
    }
    
    fileprivate func validate(phone: String, password: String) -> Error? {
        if (phone.isEmpty) {
            return NSError(message: "Vui lòng nhập số điện thoại!")
        }
        
        if !phone.isEmailValid {
            return NSError(message: "Số điện thoại không đúng định dạng. Vui lòng nhập lại!")
        }
        
        if password.isEmpty {
            return NSError(message: "Xin vui lòng nhập mật khẩu!")
        }
        
        if !password.isPasswordValid {
            return NSError(message: "Mật khẩu phải có ít nhất 6 ký tự.")
        }
        return nil
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
                    let msg = "Mật khẩu hoặc số điẹn thoại không đúng"
                    let err = NSError(message: msg)
                    self.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: err)
                }
            }).error(completion: { (error) in
                let msg = "Mật khẩu hoặc số điẹn thoại không đúng"
                let err = NSError(message: msg)
                self.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: err)
            })
        })
    }
}
    

