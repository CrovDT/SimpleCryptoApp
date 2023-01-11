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

        private let coinDataService = CoinDataService()

        private var cancellables = Set<AnyCancellable>()

        init() {
            addSubscribers()
        }

        func addSubscribers() {
            coinDataService.$allCoins
                .sink { [weak self] receivedCoins in
                    guard let self = self else { return }
                    self.allCoins = receivedCoins
                }
                .store(in: &cancellables)
        }

        func updateCoins() {
            coinDataService.getCoins()
        }

    }
