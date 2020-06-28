
//
//  ProceedOrderVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/25/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class ProceedOrderVC: UIViewController {

    @IBOutlet weak var moneyTotalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var listProducts = [ProductObject]()
    var amount = Int()
    var isDelete = false
    var sum = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        listProducts = RealmService.shared.getAll(for: ProductObject.self)
        configureTableView()
        moneyTotal()
        // Do any additional setup after loading the view.
    }
    
    func moneyTotal() {
        listProducts.map({$0.Price}).forEach({price in
            sum += price
        })
        ObjectManager.shared.moneyTotal.accept(sum)
        moneyTotalLabel.text = "\(sum)"
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        back()
    }
    
    @IBAction func actionCart(_ sender: UIButton) {
        goto(withStoryboar: "Home", withIndentifier: ProceedOrderVC.reuseIdentifier)
    }
    
    @IBAction func actionOrder(_ sender: UIButton) {
        gotoBlock(withStoryboar: "Home", aClass: ConfirmOrrderVC.self) { (vc) in
            vc?.money = sum
        }
    }
}

extension ProceedOrderVC {
    func configureTableView() {
        tableView.do {
            $0.registerNib(aClass: ProceedOrderTableViewCell.self)
            $0.configure(self)
            $0.height = 200
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Hiện tại bạn chưa có tài khoản", message: "Hãy đăng nhập để tiếp tực", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (alertAction ) in
            
        }))
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { (alertAction) in
            self.goto(withStoryboar: "Home", withIndentifier: ProfileVC.reuseIdentifier)
        }))
        
        self.present(alert,animated: true)
    }
}

extension ProceedOrderVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeue(aClass: ProceedOrderTableViewCell.self, for: indexPath)
        cell.updateData(product: listProducts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Xoá") { (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            let alert = UIAlertController(title: "Xoá giỏ hàng", message: "Bạn chắc chắn xoá sản phẩm này", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (alertAction ) in
                actionPerformed(false)
            }))
            
            alert.addAction(UIAlertAction(title: "Xoá", style: .destructive, handler: { (alertAction) in
                let elementProduct = self.listProducts[indexPath.row]
                RealmService.shared.remove(elementProduct)
                self.listProducts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                DispatchQueue.global().async(execute: {
                    DispatchQueue.main.async {
                        self.sum = 0
                        self.moneyTotal()
                    }
                })
                actionPerformed(true)
            }))
            
            self.present(alert,animated: true)
        }
        
        delete.image = UIImage(named: "x")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
