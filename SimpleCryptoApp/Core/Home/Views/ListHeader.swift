//
//  ListHeader.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 12.01.2023.
//

import SwiftUI
struct ListHeader: View {
    @EnvironmentObject private var vm: HomeViewModel

    let name: String
    let icon: String?

    let coinFilterType: CoinDataType

    var show: Bool {
        if vm.coinType == coinFilterType {
            return true
        } else {
            return false
        }
    }

    var body: some View {
        HStack {
            title
            if icon != nil && icon != nil {
                images
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .frame(height: 15)
        .onTapGesture {
            if !show {
                vm.coinType = coinFilterType
            } else {
                vm.ascending.toggle()
            }
        }
        .background {
            if show {
                Capsule()
                    .foregroundColor(show ? .theme.listHeader.opacity(0.2) : .white)
            }
        }
    }
}

extension ListHeader {
    private var title: some View {
        Text(name)
            .foregroundColor(show ? .theme.foreground : .theme.secondary)
            .lineLimit(1)
            .font(.subheadline)
            .fixedSize()
    }

    private var images: some View {
        VStack {
            Image(systemName: icon ?? "")
                .foregroundColor(vm.ascending && show ? .theme.foreground : .theme.secondary)
            Image(systemName: icon ?? "").rotationEffect(Angle(degrees: 180))
                .foregroundColor(!vm.ascending && show ? .theme.foreground : .theme.secondary)
        }
        .imageScale(.small)
        .scaleEffect(0.4)
    }
}

struct ListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ListHeader(name: "Market Cap", icon: "arrowtriangle.up.fill",
                   coinFilterType: .hot)
    }
}
