//
//  CurrenceCellViewModel.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import UIKit

struct CurrencyCellViewModel {
    let currencyImage: UIImage
    let currencyCode: String
    let currencyName: String
    
    init(_ currency: Currency) {
        currencyImage = currency.flag
        currencyCode = currency.rawValue
        currencyName = currency.name
    }
}
