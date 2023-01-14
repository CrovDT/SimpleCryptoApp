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
    private let imageName: String
    private  let coin: Coin

    init(coin: Coin) {
        self.coin = coin
        imageName = coin.id
        getImage()
    }

    private let folderName = "coin_images"

   func getImage() {
         guard
        let image = LocalFileManager.instance.getImage(for: folderName,
                                                       imageName: imageName, fileExtension: ".png") else {
             do {
                 try fetchImage(from: coin)
                 print("Image fetched from the Internet")
                 return
             } catch let error {
                 print(error.localizedDescription)
                 return
             }
         }
       print("Image downloaded from FileManager")
       self.image = image
    }

    func fetchImage(from coin: Coin) throws {
        guard let url = URL(string: coin.image) else { throw APIError.invalidURL(coin.image)}
       imageSubscription = NetworkingManager.download(from: url)
            .sink(receiveCompletion: NetworkingManager.handleUrl, receiveValue: { [weak self] data in
                let uiImage = UIImage(data: data)
                guard let self = self else { return }
                guard let uiImage = uiImage else { return }

                self.image = uiImage
                LocalFileManager.instance.add(image: uiImage, for: self.folderName, fileExtension: ".png",
                                              imageName: self.imageName)
                self.imageSubscription?.cancel()
            })
    }
}
