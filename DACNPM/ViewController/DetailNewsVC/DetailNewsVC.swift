//
//  DetailNewsVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/24/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class DetailNewsVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    var postNews = PostObject()
    var listPostNews = [PostObject]()
    var index = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        listPostNews.remove(at: index)
        fecthData()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    func fecthData() {
        nameLabel.text = postNews.Name
        displayImage.loadImage(from: postNews.Image)
        contentTextView.text = postNews.Content
    }
    
    @IBAction func actionBack(_ sender: UIButton) {
        back()
    }
}

extension DetailNewsVC {
    func configureTableView() {
        tableView.do {
            $0.registerNib(aClass: NewsOtherTableViewCell.self)
            $0.configure(self)
        }
    }
}

extension DetailNewsVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPostNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeue(aClass: NewsOtherTableViewCell.self, for: indexPath)
        cell.updateData(post: listPostNews[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let posts = listPostNews[indexPath.row]
        let list = listPostNews
        gotoBlock(withStoryboar: "Home", aClass: DetailNewsVC.self) { (vc) in
            vc?.postNews = posts
            vc?.listPostNews = list
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
