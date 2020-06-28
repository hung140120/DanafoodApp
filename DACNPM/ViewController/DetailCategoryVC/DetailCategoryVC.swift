
//
//  DetailCategory.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/4/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class DetailCategoryVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var productForCategory = [ProductObject]()
    var viewModel = DetailCategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        back()
    }
}

extension DetailCategoryVC {
    func configureCollectionView() {
        tableView.do {
            $0.registerNib(aClass: DetailCatelogyTableViewCell.self)
            $0.configure(self)
            $0.height = 200
        }
    }
}

extension DetailCategoryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productForCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeue(aClass: DetailCatelogyTableViewCell.self, for: indexPath)
        cell.updateData(prodcut: productForCategory[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoBlock(withStoryboar: "Home", aClass: Detail2CategoryVC.self) { (vc) in
            vc?.products = productForCategory[indexPath.row]
            vc?.index = indexPath.row
            vc?.listProducts = productForCategory
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
