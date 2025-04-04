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
    static let priority = Priority()
}

struct Theme {
    let accentToWhite = [Color.accentColor, .white]
    let whiteToAccent = [.white, Color.accentColor]
    let appGray = Color("AppGray")
    let fontColor = Color("FontColor")
}

struct Priority {
    let Red = Color(.red)
    let Orange  = Color(.orange)
    let Yellow  = Color(.yellow)
    let Green  = Color(.green)
    let Blue  = Color(.blue)
    let Purple  = Color(.purple)
    let Gray  = Color(.gray)
}
