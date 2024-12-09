//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case serverError
}

protocol NetworkServiceProtocol {
    func convert(_ current: Currency, amount: Double, into destination: Currency) async -> Result<Data, NetworkError>
}

class NetworkService: NetworkServiceProtocol {
    
    private let BaseUrl = "http://api.evp.lt/"
    
    func convert(_ current: Currency, amount: Double, into destination: Currency) async -> Result<Data, NetworkError> {
        let urlString = BaseUrl + "currency/commercial/exchange/\(amount)-\(current.rawValue)/\(destination.rawValue)/latest"
        guard let url = URL(string: urlString) else {
            return Result.failure(.badUrl)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return Result.success(data)
        } catch {
            return Result.failure(.serverError)
        }
    }
}

class NetworkServiceMock: NetworkServiceProtocol {

    func convert(_ current: Currency, amount: Double, into destination: Currency) async -> Result<Data, NetworkError> {
        sleep(1)
        let jsonString = "{\"fromCurrency\": \"\(current.rawValue)\", \"fromCurrencyAmount\": \"\(amount)\", \"toCurrency\": \"\(destination.rawValue)\", \"toCurrencyAmount\": \"\(Double.random(in: 100...10000))\"}"
        if let jsonData = jsonString.data(using: .utf8) {
            return Result.success(jsonData)
        } else {
            return Result.failure(.serverError)
        }
    }
}
