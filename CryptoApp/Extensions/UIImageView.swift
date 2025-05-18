//
//  UIImageView.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: String) {
        guard let url = URL(string: url) else { return }
        self.kf.setImage(with: url)
    }
}
