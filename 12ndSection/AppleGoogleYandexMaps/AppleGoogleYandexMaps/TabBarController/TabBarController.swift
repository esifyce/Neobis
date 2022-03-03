//
//  ViewController.swift
//  MapKit
//
//  Created by Sabir Myrzaev on 2/3/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
         super.viewDidLoad()

         // create instance of view controllers
         let appleMaps = AppleMapsController()
         let googleMaps = GoogleMapsController()
         let yandexMaps = YandexMapsController()
        
         // set title
         appleMaps.title = "AppleMap"
         googleMaps.title = "GoogleMap"
         yandexMaps.title = "YandexMap"
         
         // assign vc to TabBar
         setViewControllers([appleMaps, googleMaps, yandexMaps], animated: true)
         
         guard let items = self.tabBar.items else { return }
         
         let images = ["map", "mappin.and.ellipse", "mappin"]
         
         for i in 0...images.count - 1 {
             items[i].image = UIImage(systemName: images[i])
         }
         
         // restyle tabbar
         tabBarRestyle()
        updateTabBarAppearance()
        

     }
    
    fileprivate func updateTabBarAppearance(){

        if #available(iOS 13, *) {
          let appearance = UITabBarAppearance()
          appearance.backgroundColor = UIColor.white
          appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.lightGray]
          appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.red]
          appearance.stackedItemPositioning = .automatic
          tabBar.standardAppearance = appearance
          tabBar.scrollEdgeAppearance = appearance
        }

     }

     private func tabBarRestyle() {
         
         if  UIScreen.main.bounds.size.height > 750 {
             self.additionalSafeAreaInsets.bottom = 15
             self.tabBar.selectionIndicatorImage = UIImage(named: "Selected")
         }
         self.tabBar.layer.masksToBounds = true
         self.tabBar.layer.cornerRadius = 30
         self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
         self.tabBar.tintColor = UIColor.systemRed
     }
}

