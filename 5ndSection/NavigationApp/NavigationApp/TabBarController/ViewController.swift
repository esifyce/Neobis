//
//  ViewController.swift
//  NavigationApp
//
//  Created by Sabir Myrzaev on 26.01.2022.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create instance of view controllers
        let todoVC = HomeViewController()
        let clockVC = TimerStopWatchViewController()
        
        // set title
        todoVC.title = "ToDo"
        clockVC.title = "Clock"
        
        // assign vc to TabBar
        setViewControllers([clockVC, todoVC], animated: true)
        
        guard let items = self.tabBar.items else { return }
        
        let images = ["clock.arrow.2.circlepath", "scroll"]
        
        for i in 0...images.count - 1 {
            items[i].image = UIImage(systemName: images[i])
        }
        
        // changing tint color
        tabBar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
    }


}

