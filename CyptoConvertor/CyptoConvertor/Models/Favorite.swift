//
//  Favorite.swift
//  CyptoConvertor
//
//  Created by Malick Moro-Samah on 30/03/2024.
//

import Foundation

struct FavoriteCurrencyPair: Identifiable {
    let id = UUID()
    var fromCurrency: Currency
    var toCurrency: Currency
}
