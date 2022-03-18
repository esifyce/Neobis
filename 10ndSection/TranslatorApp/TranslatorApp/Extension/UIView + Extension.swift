//
//  UIView + Extension.swift
//  TranslatorApp
//
//  Created by Sabir Myrzaev on 18/3/22.
//

import UIKit

// shodow around view
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 2
        layer.shouldRasterize = true
        layer.cornerRadius = 10
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    public func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    public func addSubviewsList(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
