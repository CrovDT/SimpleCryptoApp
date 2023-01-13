//
//  CoinImageService.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 13.01.2023.
//

import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage?

    private var imageSubscription: AnyCancellable?

    init(coin: Coin) {
        do {
            try fetchImage(from: coin)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func fetchImage(from coin: Coin) throws {
        guard let url = URL(string: coin.image) else { throw APIError.invalidURL(coin.image)}
       imageSubscription = NetworkingManager.download(from: url)
            .sink(receiveCompletion: NetworkingManager.handleUrl, receiveValue: { [weak self] data in
                let uiImage = UIImage(data: data)
                guard let self = self else { return }
                guard let uiImage = uiImage else { return }

                self.image = uiImage
                self.imageSubscription?.cancel()
            })
    }
}
