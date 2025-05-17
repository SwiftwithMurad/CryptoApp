//
//  AppCoordinator.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var window: UIWindow
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        let controller = TabBarController()
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
