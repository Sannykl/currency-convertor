//
//  ConvertationModel.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import Foundation

struct ConvertationModel: Decodable {
    let fromCurrency: String
    let fromCurrencyAmount: String
    let toCurrency: String
    let toCurrencyAmount: String
}
