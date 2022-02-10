//
//  ViewController.swift
//  HardUIComponents
//
//  Created by Sabir Myrzaev on 09.02.2022.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // create instance of view controllers
        let cryptoTableVC = CryptoTableViewController()
        let financeTableVC = FinanceTableViewController()
        let cryptoCollectionVC = CryptoCollectionViewController()
        let financeCollectionVC = FinanceCollectionViewController()
        
        // set title
        cryptoTableVC.title = "Crypt"
        financeTableVC.title = "Finance"
        cryptoCollectionVC.title = "Крипта"
        financeCollectionVC.title = "Финансы"
        
        // assign vc to TabBar
        setViewControllers([cryptoTableVC, financeTableVC, cryptoCollectionVC, financeCollectionVC], animated: true)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["bitcoinsign.circle", "dollarsign.circle", "bitcoinsign.square", "dollarsign.square"]
        
        for i in 0...images.count - 1 {
            items[i].image = UIImage(systemName: images[i])
        }
        
        // restyle tabbar
        tabBarRestyle()
    }

    private func tabBarRestyle() {
        
        if  UIScreen.main.bounds.size.height > 750 {
            self.additionalSafeAreaInsets.bottom = 15
            self.tabBar.selectionIndicatorImage = UIImage(named: "Selected")
        }
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 30
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.tabBar.tintColor = UIColor(named: "TabBarTint")
    }

}

