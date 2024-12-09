//
//  CurrencyViewModel.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import UIKit

enum CurrencyType {
    case from
    case to
}

class CurrencyViewModel {
    var titleString: String = "YOU PAY"
    var textColor: UIColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 1.0)
    var backgroundColor = UIColor.yellow.withAlphaComponent(0.7)
    var borderColor = UIColor.yellow.withAlphaComponent(0.8)
    var arrowIcon = UIImage(resource: .arrowDropDownFill)
    var isTextFieldEnabled = true
    var currencyType = CurrencyType.from
    var textFieldPlaceholder = "0"

    @Published var currencyImage: UIImage
    @Published var currencyString: String
    @Published var currencyName: String
    @Published var currencyAmount: String = ""
    
    init(_ currency: Currency) {
        currencyImage = currency.flag
        currencyString = currency.rawValue
        currencyName = currency.name
    }
    
    func didChangeCurrency(_ currency: Currency) {
        currencyImage = currency.flag
        currencyString = currency.rawValue
        currencyName = currency.name
    }
    
    func didUpdateConvertation(_ convertation: ConvertationModel) {}
    
    func shouldSetZeroAmount() {}
}



final class ToCurrencyViewModel: CurrencyViewModel {
        
    override init(_ currency: Currency) {
        super.init(currency)
        titleString = "YOU GET"
        textColor = .white
        backgroundColor = .white.withAlphaComponent(0.1)
        borderColor = .white.withAlphaComponent(0.2)
        arrowIcon = UIImage(resource: .arrowDropDownFillWhite)
        isTextFieldEnabled = false
        currencyType = .to
    }
    
    override func didChangeCurrency(_ currency: Currency) {
        currencyImage = currency.flag
        currencyString = currency.rawValue
        currencyName = currency.name
    }
    
    override func didUpdateConvertation(_ convertation: ConvertationModel) {
        guard let amount = Double(convertation.toCurrencyAmount) else {
            currencyAmount = ""
            return
        }
        currencyAmount = String(format: "%.3f", amount)
    }
    
    override func shouldSetZeroAmount() {
        currencyAmount = ""
    }
}
