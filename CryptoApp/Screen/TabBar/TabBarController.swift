//
//  TabBarController.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureControllers()
    }
    
    private func configureControllers() {
        let firstVC = UINavigationController(rootViewController: HomeController())
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        
        viewControllers = [firstVC]
    }
}
