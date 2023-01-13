//
//  Home.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 11.01.2023.
//

import SwiftUI

struct Home: View {
    @ObservedObject var homeViewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                VStack {
                    HeaderView()
                        .padding()

                        BalanceView()
                            .padding()

                        StaticListRow(vm: homeViewModel)

                        coins

                }
            }
        }
    }
}

extension Home {
    private var coins: some View {
        List {
            ForEach(homeViewModel.filteredCoins) { coin in
                CoinRow(coin: coin, vm: homeViewModel)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .refreshable {
            homeViewModel.updateCoins()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(homeViewModel: HomeViewModel())
    }
}
