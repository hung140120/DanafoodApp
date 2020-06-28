//
//  ProfileVC.swift
//  DACNPM
//
//  Created by Dinh Hung on 6/26/20.
//  Copyright © 2020 Dinh Hung. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var donHangView: UIView!
    @IBOutlet weak var personView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    var user = [UserObject]()
    var isLogined = true
    override func viewDidLoad() {
        super.viewDidLoad()
        //user = RealmService.shared.getAll(for: UserObject.self)
        nameLabel.text = UDKey.User.fullname.value
        checkUser()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkUser()
    }
    
    @IBAction func actioBack(_ sender: UIButton) {
        back()
    }
    
    @IBAction func acitonCart(_ sender: UIButton) {
        goto(withStoryboar: "Home", withIndentifier: ProceedOrderVC.reuseIdentifier)
    }
    
    func checkUser() {
        let token = UDKey<String>.User.token.value ?? ""
        
        if !token.isEmpty  {
            loginButton.isHidden = true
            signUpButton.isHidden = true
            avatar.isHidden = false
            nameLabel.isHidden = false
            personView.isHidden = false
            logoutButton.isHidden = false
        } else {
            loginButton.isHidden = false
            signUpButton.isHidden = false
            avatar.isHidden = true
            nameLabel.isHidden = true
            personView.isHidden = true
            logoutButton.isHidden = true
        }
    }
    @IBAction func actionLogin(_ sender: UIButton) {
        goto(withStoryboar: "Login", withIndentifier: SignInVC.reuseIdentifier)
    }
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        goto(withStoryboar: "Login", withIndentifier: SignUpVC.reuseIdentifier)
    }
    
    @IBAction func actionLogout(_ sender: UIButton) {
        UDKey<String>.User.token.set(nil)
        UDKey<String>.User.username.set(nil)
        UDKey<String>.User.email.set(nil)
        UDKey<String>.User.fullname.set(nil)
        UDKey<String>.User.address.set(nil)
        UDKey<String>.User.birthday.set(nil)
        UDKey<String>.User.phonenumber.set(nil)
        checkUser()
    }
    
    @IBAction func gotoCart(_ sender: UIButton) {
        goto(withStoryboar: "Home", withIndentifier: ProceedOrderVC.reuseIdentifier)
    }
    
    @IBAction func gotoUserInfo(_ sender: UIButton) {
        goto(withStoryboar: "Home", withIndentifier: UserInfoVC.reuseIdentifier)
    }
}
