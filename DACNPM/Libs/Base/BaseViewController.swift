//
//  BaseViewController.swift
//  easteregg
//
//  Created by Vu Xuan Hoa on 9/25/19.
//  Copyright © 2019 Vu Xuan Hoa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        initViews()
        bindRx()
    }
    
    func initViews() {
        
    }
    
    func bindRx() {
        
    }
}

extension BaseViewController {
    @objc @IBAction func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc @IBAction func actionBack() {
        back()
    }
}

extension BaseViewController: MVVMViewDelegate {
}
