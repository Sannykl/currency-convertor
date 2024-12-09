//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import Foundation

struct CurrencyListViewModel {
    
    let listType: CurrencyType
    let cellViewModels: [CurrencyCellViewModel]
    
    init(_ listType: CurrencyType, models: [Currency]) {
        self.listType = listType
        cellViewModels = models.map { CurrencyCellViewModel($0) }
    }
}
