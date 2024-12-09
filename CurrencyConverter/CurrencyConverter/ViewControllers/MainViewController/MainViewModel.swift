//
//  MainViewModel.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import UIKit
import Combine

final class MainViewModel {
    
    private let networkService: NetworkServiceProtocol
        
    let titleString = "Currency converter"
    @Published private(set) var errorString = ""
    
    private var fromCurrency = Currency.usd
    private var fromAmount: Double = 0.0
    private var toCurrency = Currency.eur
        
    init(_ networkService: NetworkServiceProtocol = NetworkServiceMock()) {
        self.networkService = networkService
    }
    
    func updateConvertionInfo() {
        Task {
            let result = await networkService.convert(fromCurrency, amount: fromAmount, into: toCurrency)
            switch result {
            case .success(let data):
                do {
                    let convertationModel = try JSONDecoder().decode(ConvertationModel.self, from: data)
                    await didReceiveData(convertationModel)
                } catch {
                    await MainActor.run {
                        errorString = "We can't make this convertation right now. please try again later."
                    }
                }
            case .failure(let failure):
                await MainActor.run {
                    switch failure {
                    case .badUrl:
                        errorString = "Something went wrong"
                    case .serverError:
                        errorString = "We can't make this convertation right now. please try again later."
                    }
                }
            }
        }
    }
    
    private func didReceiveData(_ model: ConvertationModel) async {

    }
    
    func replaceCurencies() {

    }
    
    func didChangeCurrentAmount(_ text: String) {
        guard let amount = Double(text) else {
            return
        }
        fromAmount = amount
        updateConvertionInfo()
    }
}
