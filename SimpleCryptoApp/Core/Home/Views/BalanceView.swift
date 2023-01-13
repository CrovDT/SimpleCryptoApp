//
//  BalanceView.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 12.01.2023.
//

import SwiftUI

struct BalanceView: View {
    @Environment(\.colorScheme) var userTheme
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("Total balance")
                    Image(systemName: "eye")
                }
                .font(.subheadline)
                Text(43.3, format: .currency(code: "USD"))
                    .font(.title.weight(.bold))
                    .foregroundColor(.theme.balance)
            }
            .offset(CGSize(width: 40, height: 0))
            Spacer()
            Image(systemName: "arrowshape.right.fill")
                .padding(.horizontal, 10)
        }
        .foregroundColor(.theme.foreground)
        .padding()
            .frame(maxWidth: .infinity)
            .frame(minHeight: 115)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(.theme.secondary.opacity(0.1))
            )
            .shadow(color: .theme.foreground, radius: userTheme == .dark ? 3 : 0.5)
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
    }
}
