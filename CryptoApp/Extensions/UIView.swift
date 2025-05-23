//
//  UIView.swift
//  CryptoApp
//
//  Created by Mac on 18.05.25.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
