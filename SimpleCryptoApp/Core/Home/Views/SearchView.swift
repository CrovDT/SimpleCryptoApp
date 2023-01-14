//
//  SearchView.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 13.01.2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var vm: HomeViewModel

    var body: some View {
        VStack {
            SearchBar()
            CoinListView()
        }
        .navigationBarBackButtonHidden()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
