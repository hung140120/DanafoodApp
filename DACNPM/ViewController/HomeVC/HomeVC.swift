//
//  HomeVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 5/21/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit
import Then

class HomeVC: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureTableView()
    }
    
    @IBAction func actionCart(_ sender: UIButton) {
        goto(withStoryboar: "Home", withIndentifier: ProceedOrderVC.reuseIdentifier)
    }
    
}

extension HomeVC {
    func configureTableView() {
        newsTableView.do {
            $0.registerNib(aClass: NewsTableViewCell.self)
            $0.configure(self)
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let posts = viewModel.posts.value
        let cell = newsTableView.dequeue(aClass: NewsTableViewCell.self, for: indexPath)
        cell.updateData(post: posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoBlock(withStoryboar: "Home", aClass: DetailNewsVC.self) { (vc) in
            vc?.postNews = viewModel.posts.value[indexPath.row]
            vc?.listPostNews = viewModel.posts.value
            vc?.index = indexPath.row
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
