//
//  SearchBar.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 14.01.2023.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var searchTextField: Bool

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.theme.secondary)

            TextField("Search", text: $vm.searchText)
                .focused($searchTextField)

            Button {
                dismiss()
                vm.searchText = ""
            } label: {
                Text("Cancel")
                    .foregroundColor(.theme.foreground)
            }
        }
        .padding()
        .background(
        Capsule()
            .foregroundColor(.theme.secondary.opacity(0.2))
            .padding(.horizontal, 3)
        )
        .onAppear {
            searchTextField = true
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
