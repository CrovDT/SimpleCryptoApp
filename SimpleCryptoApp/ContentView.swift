//
//  ContentView.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 10.01.2023.
//

import SwiftUI
enum SelectedTab {
    case crypto, wallet
}

struct ContentView: View {
    @Binding var selectedTab: SelectedTab

    var body: some View {
        TabView(selection: $selectedTab) {
            Home()
                .tabItem {
                    VStack {
                        Label("Crypto", systemImage: "bitcoinsign.circle")
                    }
                }
                .tag(SelectedTab.crypto)

            Text("Wallet")
                .tabItem {
                    Label("Wallet", systemImage: "wallet.pass")
                }
                .tag(SelectedTab.wallet)
        }
        .tint(.theme.foreground.opacity(0.8))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selectedTab: .constant(.wallet))
    }
}
