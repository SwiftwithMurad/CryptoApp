//
//  NetworkHelper.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import Foundation

class NetworkHelper {
    static let shared = NetworkHelper()
    private init() {}
    
    private let baseURL = "https://api.coingecko.com/api/v3"
    
    func setURL(with string: String) -> String {
        baseURL + string
    }
}
