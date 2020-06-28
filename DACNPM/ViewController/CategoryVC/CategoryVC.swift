//
//  CategoryVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 5/28/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel = CategoryViewModel()
    var listProductCategory = [ProductCategoryObject]()
    var categorySelected = Int()
    var productForCategory = [ProductObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionCart(_ sender: UIButton) {
        goto(withStoryboar: "Home", withIndentifier: ProceedOrderVC.reuseIdentifier)
    }
}

extension CategoryVC {
    func configureCollectionView() {
        collectionView.do {
            $0.register(CategoryCollectionViewCell.self)
            $0.configure(self)
            $0.minSpacing = (10,10)
        }
    }
}

extension CategoryVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productCategory.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productCategorys = viewModel.productCategory.value
        let cell = self.collectionView.dequeue(aClass: CategoryCollectionViewCell.self, for: indexPath)
        cell.updateData(prodcutCategory: productCategorys[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categorySelected = viewModel.categories[indexPath.row]
        productForCategory = viewModel.products.value.filter({$0.CategoryID == categorySelected})
        gotoBlock(withStoryboar: "Home", aClass: DetailCategoryVC.self) { (vc) in
            vc?.productForCategory = productForCategory
        }
    }
}
