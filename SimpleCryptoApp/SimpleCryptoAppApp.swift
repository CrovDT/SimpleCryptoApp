//
//  SimpleCryptoAppApp.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 10.01.2023.
//

import SwiftUI

@main
struct SimpleCryptoAppApp: App {
    @StateObject var homeViewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            Home(homeViewModel: homeViewModel)
        }
    }
}
