//
//  Coordinator.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
