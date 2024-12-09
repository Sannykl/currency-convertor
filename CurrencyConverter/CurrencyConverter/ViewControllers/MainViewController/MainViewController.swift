//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 08.12.2024.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fromView: CurrencyView = {
        let view = CurrencyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let toView: CurrencyView = {
        let view = CurrencyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(red: 235/255.0, green: 64/255.0, blue: 52/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fill(with: viewModel)
        prepareUI()
    }
    
    private func fill(with viewModel: MainViewModel) {
        titleLabel.text = viewModel.titleString
        viewModel.$errorString.sink { [weak self] errorString in
            self?.errorLabel.text = errorString
        }.store(in: &subscriptions)
    }
    
    private func prepareUI() {
        view.backgroundColor = UIColor(red: 10/255.0, green: 15/255.0, blue: 46/255.0, alpha: 1.0)

        addTitle()
        addFromCurrencyView()
        addToCurrencyView()
        addReverseButton()
        addErrorLabel()
    }
    
    private func addTitle() {
        view.addSubview(titleLabel)
        
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
     }
    
    private func addFromCurrencyView() {
        view.addSubview(fromView)
        
        let constraints = [
            fromView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            fromView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            fromView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            fromView.heightAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addToCurrencyView() {
        view.addSubview(toView)
        
        let constraints = [
            toView.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: 10),
            toView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            toView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            toView.heightAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addReverseButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(resource: .arrowUpDownFill), for: .normal)
        button.backgroundColor = UIColor(red: 227/255.0, green: 232/255.0, blue: 229/255.0, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1.0).cgColor
        
        button.addTarget(self, action: #selector(revertButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        let constraints = [
            button.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: -15),
            button.centerXAnchor.constraint(equalTo: fromView.centerXAnchor, constant: 0),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func addErrorLabel() {
        view.addSubview(errorLabel)
        
        let constraints = [
            errorLabel.topAnchor.constraint(equalTo: toView.bottomAnchor, constant: 10),
            errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: button actions methods
private extension MainViewController {
    
    @objc func revertButtonAction() {
        viewModel.replaceCurencies()
    }
}
