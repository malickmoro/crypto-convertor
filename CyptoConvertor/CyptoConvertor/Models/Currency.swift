//
//  Currency.swift
//  CyptoConvertor
//
//  Created by Malick Moro-Samah on 30/03/2024.
//

import Foundation

struct Currency: Identifiable {
    let id = UUID()
    var code: String
    var name: String
    var symbol: String?
}

