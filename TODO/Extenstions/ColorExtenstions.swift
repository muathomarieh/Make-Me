//
//  ColorExtenstions.swift
//  TODO
//
//  Created by Muath Omarieh on 05/03/2025.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = Theme()
}

struct Theme {
    let accentToWhite = [Color.accentColor, .white]
    let whiteToAccent = [.white, Color.accentColor]
    let appGray = Color("AppGray")
}
