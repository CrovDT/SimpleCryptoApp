//
//  PortfolioView.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 14.01.2023.
//

import SwiftUI

struct PortfolioView: View {
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar()
            CoinListView()
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
