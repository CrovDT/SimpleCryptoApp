//
//  HomeViewModel.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 11.01.2023.
//

import Foundation
import Combine

     class HomeViewModel: ObservableObject {
        @Published var allCoins: [Coin] = []
        @Published var coinType: CoinDataType = .hot
        @Published var ascending = false
        @Published var searchText = ""

         @Published var selectedTab: SelectedTab = .crypto

        private let coinDataService = CoinDataService()

        private var cancellables = Set<AnyCancellable>()

        var filteredCoins: [Coin] {
            switch coinType {
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
            case .portfolio:
                return allCoins.filter { $0.currentHoldings != nil }
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

            // subscribe on changing searching
            $searchText
                .combineLatest(coinDataService.$allCoins)
                .map(filterCoins)
                .sink { [weak self] filteredCoins in
                    guard let self = self else { return }
                    self.allCoins = filteredCoins
                }
                .store(in: &cancellables)

            $selectedTab
                .sink { [weak self] tab in
                    if tab == .wallet {
                        self?.coinType = .portfolio
                        return
                     } else {
                         self?.coinType = .hot
                        return
                     }
                }
                .store(in: &cancellables)
        }

        func updateCoins() {
            do {
                try coinDataService.getCoins()
            } catch let error {
                print(error)
            }
        }

        private func filterCoins(text: Published<String>.Publisher.Output,
                                 coins: Published<[Coin]>.Publisher.Output ) -> [Coin] {
            guard !text.isEmpty else { return coins}

            let filteredCoins = coins.filter {
                $0.id.localizedCaseInsensitiveContains(text) ||
                $0.symbol.localizedCaseInsensitiveContains(text) ||
                $0.name.localizedCaseInsensitiveContains(text)
            }
            return filteredCoins
        }

    }
