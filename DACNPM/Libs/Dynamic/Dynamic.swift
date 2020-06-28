//
//  Dynamic.swift
//  zody-native-app
//
//  Created by TruongVO07 on 5/31/18.
//  Copyright © 2018 Zody. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Dynamic<T> {
    typealias Listener = (T?) -> ()
    typealias Function = () -> ()
    
    var listener: Listener?
    var activeFunction: Function?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        bind(listener)
        fire()
    }
    
    func runActiveFunction() {
        guard activeFunction != nil else { return }
        DispatchQueue.main.async {
            self.activeFunction!()
        }
    }
    
    func fireAndRunActiveFunction() {
        guard activeFunction != nil else { return }
        DispatchQueue.main.async {
            self.fire()
            self.activeFunction!()
        }
    }
    
    func fire() {
        DispatchQueue.main.async {
            guard let listener = self.listener else { return }
            listener(self.value)
        }
    }
    
    var value: T? {
        didSet {
            fire()
        }
    }
    
    init(_ v: T? = nil) {
        value = v
    }
}

typealias LoadmoreData = (isEnd: Bool, nextPageToken: String)

class NetworkResult<T> {
    let isLoading: Bool
    let error: Error?
    let data: T?
    let isEnd: Bool
    
    init(isLoading: Bool, data: T?, error: Error?, isEnd: Bool = true) {
        self.isLoading = isLoading
        self.data = data
        self.error = error
        self.isEnd = isEnd
    }
    
    var isValid: Bool {
        return data != nil
    }
}
