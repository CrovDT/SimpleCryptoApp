//
//  CoinImageViewModel.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 13.01.2023.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage?

    private let coinImageService: CoinImageService

    private var cancellables = Set<AnyCancellable>()

    init(coin: Coin) {
            coinImageService = CoinImageService(coin: coin)
            addSubscribers()
    }

    func addSubscribers() {
        coinImageService.$image
            .sink { [weak self] uiImage in
                guard let self = self else { return }
                self.image = uiImage
            }
            .store(in: &cancellables)
    }
}
