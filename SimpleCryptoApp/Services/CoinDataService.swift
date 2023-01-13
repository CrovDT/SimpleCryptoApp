//
//  CoinDataService.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 10.01.2023.

// API URL:
/* https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 */

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [Coin] = []

    init() {
        do {
            try getCoins()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    // swiftlint:disable:next line_length
    let url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"

    var coinSubscription: AnyCancellable?

    func getCoins() throws {
        guard let url = URL(string: url) else { throw APIError.invalidURL(url) }

        coinSubscription = NetworkingManager.download(from: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleUrl,
                  receiveValue: { [weak self] receivedCoins in
                guard let self = self else { return }
                self.allCoins = receivedCoins
                self.coinSubscription?.cancel()
            })
    }
}
