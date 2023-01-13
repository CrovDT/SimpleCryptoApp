//
//  CoinImage.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 13.01.2023.
//

import SwiftUI

struct CoinImage: View {

    @StateObject var coinImageViewModel: CoinImageViewModel

    init(coin: Coin) {
        _coinImageViewModel = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    var body: some View {
        Group {
            if let uiImage = coinImageViewModel.image {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image(systemName: "questionmark.square.dashed")
                    .resizable()
            }
        }
        .frame(width: 30, height: 30)
    }
}

struct CoinImage_Previews: PreviewProvider {
    static var previews: some View {
        CoinImage(coin: Coin.example)
    }
}
