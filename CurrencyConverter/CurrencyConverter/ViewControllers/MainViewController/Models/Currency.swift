//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import UIKit

enum Currency: String, CaseIterable {
    case usd = "USD"
    case eur = "EUR"
    case jpy = "JPY"
    case gbp = "GBP"
    case aud = "AUD"
    case cad = "CAD"
    case chf = "CHF"
    case cnh = "CNH"
    case hkd = "HKD"
    case nzd = "NZD"
    
    var name: String {
        switch self {
        case .usd:
            "US Dollar"
        case .eur:
            "Euro"
        case .jpy:
            "Japanese Yen"
        case .gbp:
            "British Pounds"
        case .aud:
            "Australian dollar"
        case .cad:
            "Canadian dollar"
        case .chf:
            "Swiss franc"
        case .cnh:
            "Chinese renminbi"
        case .hkd:
            "Hong Kong dollar"
        case .nzd:
            "New Zealand dollar"
        }
    }
    
    var flag: UIImage {
        switch self {
        case .usd:
            UIImage(resource: .flagOfUnitedStates)
        case .eur:
            UIImage(resource: .flagOfEuropeanUnion)
        case .jpy:
            UIImage(resource: .flagOfJapan)
        case .gbp:
            UIImage(resource: .flagOfUnitedKingdom)
        case .aud:
            UIImage(resource: .flagOfAustralia)
        case .cad:
            UIImage(resource: .flagOfCanada)
        case .chf:
            UIImage(resource: .flagOfSwitzerland)
        case .cnh:
            UIImage(resource: .flagOfPeoplesRepublicOfChina)
        case .hkd:
            UIImage(resource: .flagOfHongKong)
        case .nzd:
            UIImage(resource: .flagOfNewZealand)
        }
    }
}
