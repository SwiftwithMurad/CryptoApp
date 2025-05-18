//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Mac on 17.05.25.
//

import Foundation

enum ViewState {
    case loading
    case loaded
    case success
    case error(String)
    case idle
}

class HomeViewModel {
    private let coinsManager = CoinsHomeManager()
    private(set) var coins = [CoinModel]()
    var sendState: ((ViewState) -> Void)?
    
    private var state: ViewState = .idle {
        didSet {
            sendState?(state)
        }
    }
    
    func fetchCoins() async {
        state = .loading
        do {
            coins = try await coinsManager.getCoins()
            state = .loaded
            state = .success
        } catch {
            state = .loaded
            state = .error(error.localizedDescription)
        }
    }
    
    func refreshCoins() {
        coins.removeAll()
        Task {
            await fetchCoins()
        }
        state = .success
    }
}
