//
//  Color.swift
//  SimpleCryptoApp
//
//  Created by Daniil Tretyak on 10.01.2023.
//

import Foundation
import SwiftUI

extension Color {
static let theme = ColorTheme()
}

/// Struct for custom colors
struct ColorTheme {
    let background = Color("Background")
    let foreground = Color("Foreground")
    let secondary = Color("Secondary")
    let listHeader = Color("ListHeader")
    let red = Color("Red")
    let green = Color("Green")
    let balance = Color("Balance")
}
