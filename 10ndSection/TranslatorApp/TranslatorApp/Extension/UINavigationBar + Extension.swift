//
//  UINavigationBar + Extension.swift
//  TranslatorApp
//
//  Created by Sabir Myrzaev on 18/3/22.
//

import UIKit

extension UINavigationBar {
    static let defaultBackgroundColor = #colorLiteral(red: 0.2235294118, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
    static let defaultTintColor = UIColor.white
    
    func setTranslucent(tintColor: UIColor, titleColor: UIColor) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: titleColor]
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        } else {
            titleTextAttributes = [.foregroundColor: titleColor]
            setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            shadowImage = UIImage()
        }
        isTranslucent = true
        self.tintColor = tintColor
    }
    
    func setDefaultState() {
        isTranslucent = false
        clipsToBounds = false
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UINavigationBar.defaultBackgroundColor
            appearance.titleTextAttributes = [.foregroundColor: UINavigationBar.defaultTintColor]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
            shadowImage = UIImage()
            barTintColor = UINavigationBar.defaultBackgroundColor
            titleTextAttributes = [.foregroundColor: UINavigationBar.defaultTintColor]
        }
        
        tintColor = UINavigationBar.defaultTintColor
    }
}
