//
//  CoinListView.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 13.01.2023.
//

import SwiftUI

struct CoinListView: View {
    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {
                List {
                    ForEach(vm.filteredCoins) { coin in
                        CoinRow(coin: coin)
                    }
                    .listRowSeparator(.hidden)
                    .scrollIndicators(.hidden)
                }
                .listStyle(.plain)
                .refreshable {
                    vm.updateCoins()
                }
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView()
    }
}
