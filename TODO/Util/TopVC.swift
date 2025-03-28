//
//  TopVC.swift
//  TODO
//
//  Created by Muath Omarieh on 25/03/2025.
//

import Foundation
import UIKit

final class TopVC {
    static let shared = TopVC()
    private init() { }
    
    @MainActor
    func topViewController() -> UIViewController? {
        return UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}
