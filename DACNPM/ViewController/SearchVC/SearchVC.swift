//
//  SearchVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/3/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var keyboardhelper:KeyboardHepler!
    var viewModel = SearchViewModel()
    var searchProduct = [ProductObject]()
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        configureCollectionView()
        keyboardhelper = KeyboardHepler(self)
        if searchBar.text == "" {
            isSearching = false
        }
    }
}

extension SearchVC {
    func configureCollectionView() {
        tableView.do {
            $0.registerNib(aClass: SearchProductTableViewCell.self)
            $0.configure(self)
        }
    }
}

extension SearchVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchProduct.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeue(aClass: SearchProductTableViewCell.self, for: indexPath)
        if isSearching {
            cell.updateData(prodcut: searchProduct[indexPath.row])
        }else {
            print("chưa search")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoBlock(withStoryboar: "Home", aClass: Detail2CategoryVC.self) { (vc) in
            vc?.products = searchProduct[indexPath.row]
            vc?.index = indexPath.row
            vc?.listProducts = searchProduct
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchProduct = viewModel.products.value.filter({$0.Name.contains(searchText)})
        isSearching = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
