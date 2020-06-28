//
//  Detail2CategoryVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/4/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit
import Then

class Detail2CategoryVC: UIViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var prodcutCodeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var productsLQCollectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    var products = ProductObject()
    var listProducts = [ProductObject]()
    var index = Int()
    var amount = 1
    var image = ["TomSu","tomSuBien","nhieuTom","tomSuBien","TomSu","nhieuTom","TomSu","nhieuTom","tomSuBien"]
    var sum = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        listProducts.remove(at: index)
        configureCollectionView()
        fetchData()
        listProducts = RealmService.shared.getAll(for: ProductObject.self)
        // Do any additional setup after loading the view.
    }
    
    func updatePrice() {
        DispatchQueue.global().async(execute: {
            DispatchQueue.main.async {
                let price = self.products.Price * Double(self.amountLabel.text!)!
                self.priceLabel.text = "\(price)"
            }
        })
    }
    
    func fetchData() {
        descriptionTextView.text = products.Description
        nameLabel.text = products.Name
        priceLabel.text = "\(products.Price * Double(amount))"
        imageView.loadImage(from: products.Image)
    }
    @IBAction func actionCart(_ sender: UIButton) {
        goto(withStoryboar: "Home", withIndentifier: ProceedOrderVC.reuseIdentifier)
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        back()
    }
    @IBAction func actionReduction(_ sender: UIButton) {
        if amount == 0 {
            amountLabel.text = "\(0)"
        } else {
            amount -= 1
            amountLabel.text = "\(amount)"
        }
        updatePrice()
    }
    
    @IBAction func actionIncrease(_ sender: UIButton) {
        amount += 1
        amountLabel.text = "\(amount)"
        updatePrice()
    }
    
    @IBAction func actionAddCart(_ sender: UIButton) {
        let pro = listProducts.filter({$0.ID == products.ID})
        if pro.count == 1 {
            amount = Int(amountLabel.text!)!
            RealmService.shared.update(products, keyValue: ["Quantity" : amountLabel.text as Any])
            RealmService.shared.update(products, keyValue: ["Price" : priceLabel.text as Any])
        } else {
            RealmService.shared.add(products)
            RealmService.shared.update(products, keyValue: ["Quantity" : amountLabel.text as Any])
            RealmService.shared.update(products, keyValue: ["Price" : priceLabel.text as Any])
        }
        
        
    }
    
    @IBAction func actionBuyNow(_ sender: UIButton) {
        let token = UDKey<String>.User.token.value ?? ""
        if !token.isEmpty  {
            let pro = listProducts.filter({$0.ID == products.ID})
            if pro.count == 1 {
                amount = Int(amountLabel.text!)!
                RealmService.shared.update(products, keyValue: ["Quantity" : amountLabel.text as Any])
                RealmService.shared.update(products, keyValue: ["Price" : priceLabel.text as Any])
            } else {
                RealmService.shared.add(products)
                RealmService.shared.update(products, keyValue: ["Quantity" : amountLabel.text as Any])
                RealmService.shared.update(products, keyValue: ["Price" : priceLabel.text as Any])
            }
            let listProduct = RealmService.shared.getAll(for: ProductObject.self)
            listProduct.map({$0.Price}).forEach({ price in
                sum += price
            })
            print(sum)
            ObjectManager.shared.moneyTotal.accept(sum)
            goto(withStoryboar: "Home", withIndentifier: ConfirmOrrderVC.reuseIdentifier)
        } else {
            showAlert()
        }
    }
}

extension Detail2CategoryVC {
    func configureCollectionView() {
        productsLQCollectionView.do {
            $0.register(ProductsLQCollectionViewCell.self)
            $0.configure(self)
            $0.minSpacing = (10,10)
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

extension Detail2CategoryVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return listProducts.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellProducts = productsLQCollectionView.dequeue(aClass: ProductsLQCollectionViewCell.self, for: indexPath)
        cellProducts.updateData(prodcut: listProducts[indexPath.row])
        return cellProducts
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let products = listProducts[indexPath.row]
        let list = listProducts
        //fetchData()
        gotoBlock(withStoryboar: "Home", aClass: Detail2CategoryVC.self) { (vc) in
            vc?.products = products
            vc?.listProducts = list
            
        }
    }
}
