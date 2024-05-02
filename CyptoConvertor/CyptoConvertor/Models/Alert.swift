//
//  Alert.swift
//  CyptoConvertor
// 
//  Created by Malick Moro-Samah on 30/03/2024.
//

import Foundation

struct RateAlert: Identifiable {
    let id: UUID
    var currencyPair: (from: Currency, to: Currency)
    var targetRate: Double
    var isEnabled: Bool

    init(currencyPair: (from: Currency, to: Currency), targetRate: Double, isEnabled: Bool = true) {
        self.id = UUID()
        self.currencyPair = currencyPair
        self.targetRate = targetRate
        self.isEnabled = isEnabled
    }
}
