//
//  UIViewController + Extension.swift
//  TranslatorApp
//
//  Created by Sabir Myrzaev on 18/3/22.
//

import UIKit

// When user clicks anywhere on the view
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
