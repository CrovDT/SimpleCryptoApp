//
//  CoinRow.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 12.01.2023.
//

import SwiftUI

struct CoinRow: View {
    let coin: Coin
    @EnvironmentObject private var vm: HomeViewModel
    var body: some View {
        switch vm.coinType {
        case .price:
             hot
        case .dailyChange:
             hot
        case.marketCap:
             marketCap
        case .hot:
             hot
        case .portfolio:
            hot
        }
    }
    private var hot: some View {
        HStack {
            leftColumn
            Spacer()
        VStack(alignment: .trailing) {
            Text("\(coin.priceChangePercentage24H ?? 0.00, specifier: "%.2f") %")
                .foregroundColor((coin.priceChangePercentage24H ?? 0) > 0 ? .theme.green : .theme.red)
                .fontDesign(.rounded)
            Text("\(coin.currentPrice, specifier: "%.2f") $")
                .foregroundColor(.theme.foreground)
                .font(.subheadline)
                .fontDesign(.rounded)
        }
    }
}

    private var marketCap: some View {
        HStack {
            leftColumn
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(coin.marketCapChangePercentage24H ?? 0.00, specifier: "%.2f") %")
                    .foregroundColor((coin.priceChangePercentage24H ?? 0) > 0 ? .theme.green : .theme.red)
                    .fontDesign(.rounded)
                Text(coin.marketCap?.formattedWithAbbreviations() ?? "0.00")
                    .foregroundColor(.theme.foreground)
                    .font(.subheadline)
                    .fontDesign(.rounded)
            }
        }
    }
}

extension CoinRow {
    private var leftColumn: some View {
        HStack {
            rank
            CoinImage(coin: coin)
            VStack(alignment: .leading) {
                Text(coin.id.capitalized)
                    .foregroundColor(.theme.foreground.opacity(0.85))
                    .font(.callout.weight(.bold))
                Text(coin.symbol.uppercased())
                    .foregroundColor(.theme.secondary)
                    .font(.footnote)
            }
        }
    }

    private var rank: some View {
        Text(String(coin.rank))
            .font(.subheadline)
            .foregroundColor(.theme.secondary)
    }

}

struct CoinRow_Previews: PreviewProvider {
    static var previews: some View {
        CoinRow(coin: Coin.example)
    }
}
