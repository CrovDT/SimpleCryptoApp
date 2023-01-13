//
//  HomeViewModel.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 11.01.2023.
//

import Foundation
import Combine

    @MainActor class HomeViewModel: ObservableObject {
        @Published var allCoins: [Coin] = []
        @Published var filterCoin: CoinDataType = .hot
        @Published var ascending = false
        @Published var searchText = ""

        private let coinDataService = CoinDataService()

        private var cancellables = Set<AnyCancellable>()

        var filteredCoins: [Coin] {
            switch filterCoin {
            case .hot:
                return allCoins
            case .marketCap:
                return allCoins
            case .price:
                if ascending {
                    return allCoins.sorted { $0.currentPrice < $1.currentPrice }
                } else {
                    return allCoins.sorted { $0.currentPrice > $1.currentPrice }
                }
            case .dailyChange:
                if ascending {
                    return allCoins.sorted { $0.priceChangePercentage24H ?? 0.00 < $1.priceChangePercentage24H ?? 0.00 }
                } else {
                    return allCoins.sorted { $0.priceChangePercentage24H ?? 0.00  > $1.priceChangePercentage24H ?? 0.00}
                }
            }
        }

        init() {
            addSubscribers()
        }

        private func addSubscribers() {
            // subscribe on downloading and changing all coins
            coinDataService.$allCoins
                .sink { [weak self] receivedCoins in
                    guard let self = self else { return }
                    self.allCoins = receivedCoins
                }
                .store(in: &cancellables)

            // subscribe on changing type of filtering
//            $filterCoin

        }

        func updateCoins() {
            do {
                try coinDataService.getCoins()
            } catch let error {
                print(error)
            }
        }

    }
