//
//  UserInfoViewController.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 8/3/22.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    // MARK: - Property
    var userId: UILabel = {
        let id = UILabel()
        return id
    }()
    
    let nickname: UILabel = {
        let username = UILabel()
        return username
    }()
    
    let userName: UILabel = {
        let name = UILabel()
        return name
    }()
    
    let userEmail: UILabel = {
        let email = UILabel()
        return email
    }()
    
    let userPhone: UILabel = {
        let phone = UILabel()
        return phone
    }()
    
    let userWebsite: UILabel = {
        let website = UILabel()
        return website
    }()
    
    let userCompany: UILabel = {
        let company = UILabel()
        return company
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        title = "User info"
        
        view.backgroundColor = .white
        
        view.addSubview(userId)
        view.addSubview(userName)
        view.addSubview(nickname)
        view.addSubview(userPhone)
        view.addSubview(userWebsite)
        view.addSubview(userCompany)
        
        let stack = UIStackView(arrangedSubviews: [userId,userName,nickname, userPhone, userWebsite, userCompany])
        stack.axis = .vertical
        stack.spacing = 24
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 32,
                     paddingLeft: 32, paddingRight: 32)
    }
}
