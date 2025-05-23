//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import Foundation

// MARK: - CoinMarketModelElement
struct CoinModel: Codable, CoinsData {
    let id, symbol, name: String?
    let image: String?
    let currentPrice: Double?
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Int?
    let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H, marketCapChangePercentage24H, circulatingSupply, totalSupply: Double?
    let maxSupply: Double?
    let ath, athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let roi: Roi?
    let lastUpdated: String?
    
    var imageURL: String {
        image ?? ""
    }
    
    var nameData: String {
        symbol?.uppercased() ?? ""
    }
    
    var priceData: String {
        "$\(String((currentPrice ?? 0 / 1000)))"
    }
    
    var marketCapChange: String {
        String(marketCapChangePercentage24H ?? 0.0)
    }
    
    var marketCapData: String {
        "$\(String(marketCap ?? 0))"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
    }
}

// MARK: - Roi
struct Roi: Codable {
    let times: Double?
    let currency: String?
    let percentage: Double?
}
