//
//  UIView+Extension.swift
//  SimpleWeatherApp
//
//  Created by Onur Duyar on 28.05.2023.
//

import UIKit

extension UIView {
    func centerInSuperview() {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
       
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    func pinToEdges(of view: UIView, withInsets insets: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right)
        ])
    }
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, topPadding: CGFloat = 0, leadingPadding: CGFloat = 0, trailingPadding: CGFloat = 0, bottomPadding: CGFloat = 0) {

        translatesAutoresizingMaskIntoConstraints = false
       
        if let top{
            topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }
        
        if let leading{
            leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }
        
        if let trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: trailingPadding).isActive = true
        }
        
        if let bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: bottomPadding).isActive = true
        }
    }
}
