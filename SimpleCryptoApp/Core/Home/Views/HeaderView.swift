//
//  HeaderView.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 12.01.2023.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        NavigationStack {
            HStack {
                InfoView()
                Spacer()
                Image(systemName: "magnifyingglass")
                    .shadow(color: .theme.foreground, radius: 3)
                    .foregroundColor(.theme.secondary)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
