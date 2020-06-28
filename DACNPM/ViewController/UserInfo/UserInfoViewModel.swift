//
//  UserInfoViewModel.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/28/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

protocol UserInfoViewModelDelegate: MVVMViewDelegate {
    func goto()
}

class UserInfoViewModel: MVVMViewModel {
    
    var dynamicOfNetwork: Dynamic<NetworkResult<Any>> = Dynamic()
    var delegate: UserInfoViewModelDelegate? = nil
    init() {
        configBindding()
    }
    
    
    func UpdateUser(phone: String, name: String, password: String, address : String, birthday: String) {
        if let error = validate(name: name, phone: phone, address: address, birthday: birthday) {
            dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: error)
            return
        }
        apiUpdateUser(name: name, phone: phone, password: password, address: address, birthday: birthday)
    }
}

extension UserInfoViewModel {
    fileprivate func validate(name: String,phone: String, address : String, birthday: String) -> Error? {
        if (name.isEmpty) {
            return NSError(message: "Vui lòng nhập số điện thoại.")
        }
        
        if address.isEmpty {
            return NSError(message: "Xin vui lòng nhập địa chỉ.")
        }
        
        if birthday.isEmpty {
            return NSError(message: "Xin vui lòng nhập ngày sinh.")
        }
        
        if (phone.isEmpty) {
            return NSError(message: "Vui lòng nhập số điện thoại.")
        }
        
        if !phone.isPhoneValid {
            return NSError(message: "Số điện thoại không đúng định dạng. Vui lòng nhập lại!")
        }
        return nil
    }
}

extension UserInfoViewModel {
    fileprivate func configBindding() {
        dynamicOfNetwork.bind { [weak self] (value) in
            guard let this = self else { return }
            this.dynamicOfNetwork.value = value
        }
    }
}

extension UserInfoViewModel {
    fileprivate func apiUpdateUser(name : String, phone: String, password : String, address : String, birthday: String) {
        let param = Api.Auth.UpdateParam(phone: phone, name: name,password: password, address: address, birthday: birthday)
        dynamicOfNetwork.value = NetworkResult(isLoading: true, data: nil, error: nil)
        Api.Auth.UpdateUser(param: param) { [weak self] (result) in
            guard let this = self else { return }
            result.isSuccess(completion: { (json) in
                this.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: json, error: nil)
                self?.delegate?.goto()
                guard let data = json as? [String: Any] else { return }
                let object  = Mapper<UserObject>().map(JSON: data)
                let email = object?.Email
                let fullName = object?.Fullname
                let address = object?.Address
                let birthday = object?.Birthday
                let phoneNumber = object?.PhoneNumber
                UDKey.User.email.set(email)
                UDKey.User.fullname.set(fullName)
                print(UDKey.User.fullname.value!)
                UDKey.User.address.set(address)
                UDKey.User.birthday.set(birthday)
                print(UDKey.User.birthday.value!)
                UDKey.User.phonenumber.set(phoneNumber)
            }).error(completion: { (error) in
                let msg = "update không thành công"
                let err = NSError(message: msg)
                this.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: err)
            })
        }
    }
}
