//
//  String.swift
//  TODO
//
//  Created by Muath Omarieh on 10/03/2025.
//

import Foundation


extension String {
    var stringToDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mma"
        return formatter.date(from: self) ?? Date()
    }
}
