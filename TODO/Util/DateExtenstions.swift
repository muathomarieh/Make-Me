//
//  Formatter.swift
//  TODO
//
//  Created by Muath Omarieh on 22/02/2025.
//

import SwiftUI

extension Date {
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        return formatter.string(from: self)
    }
}
