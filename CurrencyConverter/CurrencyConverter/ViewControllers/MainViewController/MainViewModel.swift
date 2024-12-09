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
    @Published private(set) var reverseButtonHidden = false
    @Published private(set) var animationViewHidden = true
    
    private var fromCurrency = Currency.usd
    private var fromAmount: Double = 0.0
    private var toCurrency = Currency.eur
    
    private(set) var fromCurrencyViewModel: CurrencyViewModel!
    private(set) var toCurrencyViewModel: ToCurrencyViewModel!
    
    private var debounceTimer: Timer?
    private var scheduleTimer: Timer?
    
    init(_ networkService: NetworkServiceProtocol = NetworkServiceMock()) {
        self.networkService = networkService
        prepareCurrencyViewModels()
    }
    
    func updateConvertationInfo() {
        guard fromAmount > 0 else {
            toCurrencyViewModel.shouldSetZeroAmount()
            return
        }
        showLoadingAnimation()
        Task {
            let result = await networkService.convert(fromCurrency, amount: fromAmount, into: toCurrency)
            switch result {
            case .success(let data):
                do {
                    let convertationModel = try JSONDecoder().decode(ConvertationModel.self, from: data)
                    await didReceiveData(convertationModel)
                } catch {
                    await MainActor.run {
                        errorString = "We can't make this convertation right now. Please try again later."
                        hideLoadingAnimation()
                    }
                }
            case .failure(let failure):
                await MainActor.run {
                    switch failure {
                    case .badUrl:
                        errorString = "Some problems occured on our server. Please try again later."
                    case .serverError:
                        errorString = "We can't make this convertation right now. Please try again later."
                    }
                    hideLoadingAnimation()
                }
            }
        }
    }
    
    private func showLoadingAnimation() {
        reverseButtonHidden = true
        animationViewHidden = false
    }
    
    private func hideLoadingAnimation() {
        reverseButtonHidden = false
        animationViewHidden = true
    }
    
    private func didReceiveData(_ model: ConvertationModel) async {
        await MainActor.run {
            errorString = ""
            toCurrencyViewModel.didUpdateConvertation(model)
            hideLoadingAnimation()
        }
    }
    
    func replaceCurencies() {
        let tempCurrency = fromCurrency
        fromCurrency = toCurrency
        toCurrency = tempCurrency
        fromCurrencyViewModel.didChangeCurrency(fromCurrency)
        toCurrencyViewModel.didChangeCurrency(toCurrency)
        UISelectionFeedbackGenerator().selectionChanged()
        updateConvertationInfo()
        startScheduleTimer()
    }
    
    func didChangeCurrentAmount(_ text: String) {
        fromAmount = Double(text) ?? 0
        
        debounceTimer?.invalidate()
        debounceTimer = nil
        debounceTimer = Timer(timeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.updateConvertationInfo()
            self?.startScheduleTimer()
        })
        RunLoop.main.add(debounceTimer!, forMode: .common)
    }
    
    func didSelectCurrency(at index: Int, listType: CurrencyType) {
        guard index < Currency.allCases.count else { return }
        let currency = Currency.allCases[index]
        switch listType {
        case .from:
            if currency == toCurrency {
                replaceCurencies()
            } else {
                fromCurrencyViewModel.didChangeCurrency(currency)
                updateConvertationInfo()
            }
        case .to:
            if currency == fromCurrency {
                replaceCurencies()
            } else {
                toCurrencyViewModel.didChangeCurrency(currency)
                updateConvertationInfo()
            }
        }
    }
    
    private func startScheduleTimer() {
        scheduleTimer?.invalidate()
        scheduleTimer = nil
        scheduleTimer = Timer(timeInterval: 10, repeats: false, block: { [weak self] _ in
            self?.updateConvertationInfo()
            self?.startScheduleTimer()
        })
        RunLoop.main.add(scheduleTimer!, forMode: .common)
    }
}

//MARK: view model generation methods
extension MainViewModel {
    
    private func prepareCurrencyViewModels() {
        fromCurrencyViewModel = CurrencyViewModel(fromCurrency)
        toCurrencyViewModel = ToCurrencyViewModel(toCurrency)
    }
    
    func currencyListViewModel(_ listType: CurrencyType) -> CurrencyListViewModel {
        return CurrencyListViewModel(listType, models: Currency.allCases)
    }
}
