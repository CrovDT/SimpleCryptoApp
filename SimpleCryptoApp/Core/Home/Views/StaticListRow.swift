//
//  StaticListRow.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 12.01.2023.
//

import SwiftUI

struct StaticListRow: View {
    @ObservedObject var vm: HomeViewModel

    var body: some View {
        headerBar
        .padding([.top, .horizontal], 20)
        .font(.subheadline)
        .fontDesign(.rounded)
        .foregroundColor(.theme.secondary)
    }
}

extension StaticListRow {
    private var headerBar: some View {
        HStack {
            ListHeader(vm: vm, name: "Hot", icon: nil, coinFilterType: .hot)
            Spacer()
            ListHeader(vm: vm, name: "Market Cap", icon: nil, coinFilterType: .marketCap)
            Spacer()
            ListHeader(vm: vm, name: "Price", icon: "triangle.fill", coinFilterType: .price)
            Spacer()
            ListHeader(vm: vm, name: "24h Change", icon: "triangle.fill", coinFilterType: .dailyChange)
        }
    }

}

struct StaticListRow_Previews: PreviewProvider {
    static var previews: some View {
        StaticListRow(vm: HomeViewModel())
            .previewLayout(.sizeThatFits)
    }
}
