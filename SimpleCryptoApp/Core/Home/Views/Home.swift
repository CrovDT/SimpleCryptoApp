//
//  Home.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 11.01.2023.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State  var path = NavigationPath()
    @State private var showSearchView = false

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        InfoView()
                        Spacer()
                        searchIcon
                    }
                    .padding()

                    BalanceView()
                        .padding()

                    StaticListRow()
                    CoinListView()
                }
            }
            .navigationDestination(isPresented: $showSearchView) {
                SearchView()
            }
        }

    }
}

extension Home {
    private var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .shadow(color: .theme.foreground, radius: 3)
            .foregroundColor(.theme.secondary)
            .onTapGesture {
                homeViewModel.coinType = .hot
                showSearchView = true
            }
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
