//
//  TabBarController.swift
//  NewsApp
//
//  Created by Sabir Myrzaev on 7/3/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create instance of view controllers
        let posts = UINavigationController(rootViewController: PostsViewController())
        let users = UINavigationController(rootViewController: UsersViewController())
        
        posts.navigationBar.setDefaultState()
        users.navigationBar.setDefaultState()
        
        // set title
        posts.title = "All posts"
        users.title = "All users"
        
        // assign vc to TabBar
        setViewControllers([posts, users], animated: true)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["person", "paperplane"]
        
        for i in 0...images.count - 1 {
            items[i].image = UIImage(systemName: images[i])
        }
        
        setDefaultStateTabBar()
    }
    
    func setDefaultStateTabBar() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
}

