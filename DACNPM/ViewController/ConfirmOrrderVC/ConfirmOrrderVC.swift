//
//  ConfirmOrrderVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/27/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class ConfirmOrrderVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var payTextFiled: UITextField!
    @IBOutlet weak var moneyTotalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var money = Double()
    var listProducts = [ProductObject]()
    var keyboardHelper : KeyboardHepler!
    var orderDetails = [OrderDetails]()
    var viewModel = ConfirmViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHelper = KeyboardHepler(scrollView)
        money = ObjectManager.shared.moneyTotal.value
        print(money)
        fecthData()
        configureTableView()
        listProducts = RealmService.shared.getAll(for: ProductObject.self)
        orderDetails = ObjectManager.shared.orderDetails.value
        
        // Do any additional setup after loading the view.
    }
    
    
    func showAlert() {
        let alert = UIAlertController(title: "mua hàng thành công", message: "Bạn đã order thành công vui lòng xác nhận đơn hàng", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (alertAction) in
            self.listProducts.forEach({product in
                RealmService.shared.remove(product)
            })
            self.goto(withStoryboar: "Home")
        }))
        
        self.present(alert,animated: true)
    }
    
    func fecthData() {
        nameTextField.text = UDKey.User.username.value
        phoneTextField.text = UDKey.User.phonenumber.value
        addressTextField.text = UDKey.User.address.value
        moneyTotalLabel.text = "\(money)"
    }
    
    @IBAction func actionConfirm(_ sender: UIButton) {
        let token = UDKey<String>.User.token.value ?? ""
        if !token.isEmpty  {
            let orderDetails = viewModel.listProducts.map({["ProductID" : $0.ID, "Quantity" : $0.Quantity]})
            viewModel.order(orderDetails: orderDetails,moneyTotal: money)
            showAlert()
            
        } else {
            showAlert()
        }
    }
    @IBAction func actionBack(_ sender: UIButton) {
        back()
    }
    
    @IBAction func actionCart(_ sender: UIButton) {
        back(aClass: ProceedOrderVC.self, animated: true)
    }
    
    @IBAction func actionChangeAddress(_ sender: UIButton) {
        nameTextField.isUserInteractionEnabled = true
        phoneTextField.isUserInteractionEnabled = true
        addressTextField.isUserInteractionEnabled = true
        
    }
    @IBAction func actionChangeHinhThuc(_ sender: UIButton) {
        payTextFiled.isUserInteractionEnabled = true
    }
    @IBAction func actionChangeProduct(_ sender: UIButton) {
        back(aClass: CategoryVC.self, animated: true)
    }
}

extension ConfirmOrrderVC {
    func configureTableView() {
        tableView.do {
            $0.registerNib(aClass: ProductConfirmTableViewCell.self)
            $0.configure(self)
        }
    }
}

extension ConfirmOrrderVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeue(aClass: ProductConfirmTableViewCell.self, for: indexPath)
        cell.updateData(product: listProducts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
