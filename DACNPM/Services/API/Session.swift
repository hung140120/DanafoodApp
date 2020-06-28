//
//  Session.swift
//  XoSo
//
//  Created by Dinh Hung on 4/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import Foundation
import SAMKeychain

let kUserIdKey = "kUserIdKey"
final class Sesstion {
    struct Credential: CustomStringConvertible {
        var client: String
        var token: String
        
        init(client: String, token: String) {
            self.client = client
            self.token = token
        }
        
        var isValid: Bool {
            return !client.isEmpty && !token.isEmpty
        }
        
        var description: String {
            guard isValid else { return "" }
            return token
        }
        
        mutating func clear() {
            client = ""
            token = ""
        }
    }
    
//    struct LoginUser {
//        var phone: String = ""
//        var name: String = ""
//
//        var saveObj: JSObject = JSObject()
//
//        init(object: JSObject?) {
//            guard let object = object else { return }
//            phone = object["phone"] as! String
//            name = object["name"] as! String
//
//            saveObj = object
//        }
//    }
//
    var credential = Credential(client: "", token: "") {
        didSet {
            saveCredential()
        }
    }
    
//    var user: LoginUser? = LoginUser(object: UserDefaults.standard.object(forKey: kUserIdKey) as? JSObject) {
//        didSet {
//            let userDefaults = UserDefaults.standard
//            if let user = user {
//                userDefaults.set(user.saveObj, forKey: kUserIdKey)
//            } else {
//                userDefaults.removeObject(forKey: kUserIdKey)
//            }
//            userDefaults.synchronize()
//        }
//    }
}

extension Sesstion {
    fileprivate func saveCredential() {
        guard credential.isValid else { return }
        guard let host = Api.Path.baseURL.host else { return }
        SAMKeychain.setPassword(credential.token, forService: host, account: credential.client)
    }
    
    fileprivate func clearCredential() {
        credential.clear()
        guard let host = Api.Path.baseURL.host else { return }
        guard let accounts = SAMKeychain.accounts(forService: host) else { return }
        for account in accounts {
            if let acc = account[kSAMKeychainAccountKey] as? String {
                SAMKeychain.deletePassword(forService: host, account: acc)
            }
        }
    }
    
    func loadCredential() {
        guard let host = Api.Path.baseURL.host else { return }
        guard let account = SAMKeychain.accounts(forService: host)?.last,
            let name = account[kSAMKeychainAccountKey] as? String else { return }
        guard let password = SAMKeychain.password(forService: host, account: name) else { return }
        print("==> Token: \(password)")
        credential = Credential(client: name, token: password)
    }
    
    func reset() {
        clearCredential()
        //user = nil
    }
}
