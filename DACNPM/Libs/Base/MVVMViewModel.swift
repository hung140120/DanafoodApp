//
//  MVVMViewModel.swift
//  Car
//
//  Created by Dinh Hung on 1/14/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit
import RxCocoa
public protocol MVVMViewModel {
    func viewModelDidLoad()
}

public extension MVVMViewModel {
    func viewModelDidLoad() {}
    func toBehavior<T: Any>(_ value: T) -> BehaviorRelay<T> {
      return BehaviorRelay<T>(value: value)
    }
}
