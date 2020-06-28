//
//  OtherViewModel.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/27/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper

class OtherViewModel: MVVMViewModel {
    var dynamicOfNetwork: Dynamic<NetworkResult<Any>> = Dynamic()
    init() {
        configBindding()
    }
    
    func Feedback(name: String, email: String,message : String) {
        if let error = validate(name: name, email: email, message: message) {
            dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: error)
            return
        }
        FeedbackApi(name: name, email: email, messeage: message)
    }
}

extension OtherViewModel {
    fileprivate func configBindding() {
        dynamicOfNetwork.bind { [weak self] (value) in
            guard let this = self else { return }
            this.dynamicOfNetwork.value = value
        }
    }
    
    fileprivate func validate(name: String, email: String, message: String) -> Error? {
            if name.isEmpty {
                return NSError(message: "Vui lòng nhập tên của bạn!")
            }
                
            if email.isEmpty {
                return NSError(message: "Xin vui lòng nhập email của bạn!")
            }
        
            if email.isEmailValid {
                return NSError(message: "Email bạn chưa đúng định dạng!")
            }
            
            if message.isEmpty {
                return NSError(message: "Bạn chưa nhập nội dung.")
            }
            return nil
        }
    
    fileprivate func FeedbackApi(name: String, email : String, messeage : String) {
        let param = Api.Feedback.FeedbackParam(name: name, email: email, message: messeage)
        Api.Feedback.Feedback(param: param) {(result) in
            result.isSuccess(completion: { (json) in
                self.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: json, error: nil)
                print(json)
            }).error(completion: { (error) in
                let msg = "Chưa gửi được thông tin"
                let err = NSError(message: msg)
                self.dynamicOfNetwork.value = NetworkResult(isLoading: false, data: nil, error: err)
                print(error)
            })
        }
    }
}
