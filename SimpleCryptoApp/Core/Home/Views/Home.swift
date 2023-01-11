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
        List(homeViewModel.allCoins) { coin in
            Text( "\(coin.currentPrice)")
        }
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
