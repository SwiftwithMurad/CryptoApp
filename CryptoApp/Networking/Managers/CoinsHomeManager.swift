//
//  CoinsHomeManager.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import Foundation

protocol CoinsHomeManagerUseCase {
    func getCoins() async throws -> [CoinModel]
}

class CoinsHomeManager: CoinsHomeManagerUseCase {
    
    func getCoins() async throws -> [CoinModel] {
        let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h&locale=en"
        let data = try await NetworkManager.shared.getApiRequest(url: url, model: [CoinModel].self)
        return data
    }
}
