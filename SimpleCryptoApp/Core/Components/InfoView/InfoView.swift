//
//  InfoView.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 12.01.2023.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
            NavigationLink {
                EmptyView()
            } label: {
                Image(systemName: "info.square.fill")
                    .foregroundColor(.theme.secondary)
                    .font(.title.weight(.bold))
                    .shadow(color: .theme.foreground, radius: 4)
            }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .previewLayout(.sizeThatFits)
    }
}
