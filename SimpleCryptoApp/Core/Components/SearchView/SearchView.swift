//
//  SearchView.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 12.01.2023.
//

import SwiftUI

struct SearchView: View {
    @Binding var searchText: String
    @State private var showTextField = false

    var body: some View {
        if !showTextField {
            Image(systemName: "magnifyingglass")

                .font(.title.weight(.bold))
                .onTapGesture {
                        showTextField.toggle()
                }
        } else {
            HStack {
                Spacer()
                TextField("Search for crypto", text: $searchText)
                Image(systemName: "magnifyingglass")
                    .font(.title3.weight(.bold))
                    .foregroundColor(.theme.secondary)
            }
            .frame(width: 90, height: 40, alignment: .trailing)
            .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(.secondary)
                .frame(width: 100, height: 40)
            )

            .onTapGesture {
                    showTextField.toggle()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: .constant("Bitcoin"))
            .previewLayout(.sizeThatFits)
    }
}
