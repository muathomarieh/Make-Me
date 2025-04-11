//
//  Font.swift
//  TODO
//
//  Created by Muath Omarieh on 05/04/2025.
//

import Foundation
import SwiftUI

extension Font {

    static func roboto(_ weight: RobotoWeight, size: CGFloat) -> Font {
        return .custom(weight.rawValue, size: size)
    }

    enum RobotoWeight: String {
        case bold = "Roboto-Condensed-Bold"
        case light = "Roboto-Condensed-Light"
    }
}

