//
//  CurrencyView.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import UIKit

final class CurrencyView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "YOU PAY"
        label.textColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currencyImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = Currency.usd.flag
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.textColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(resource: .arrowDropDownFill)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "US Dollar"
        label.textColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 42, weight: .bold)
        textField.textColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 1.0)
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.tintColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 1.0)
        textField.keyboardType = .decimalPad
        textField.minimumFontSize = 16
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }()
    
    init() {
        super.init(frame: .zero)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareUI() {
        backgroundColor = UIColor.yellow.withAlphaComponent(0.7)
        
        layer.cornerRadius = 20.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.yellow.withAlphaComponent(0.8).cgColor
        
        prepareTitleLabel()
        prepareCurrencyImageView()
        prepareCurrencyLabel()
        prepareArrowImageView()
        prepareCurrencyNameLabel()
        prepareCurrencyButton()
        prepareTextField()
    }
    
    private func prepareTitleLabel() {
        addSubview(titleLabel)
        
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(titleConstraints)
    }
    
    private func prepareCurrencyImageView() {
        addSubview(currencyImageView)
        
        let imageViewConstraints = [
            currencyImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            currencyImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 35),
            currencyImageView.widthAnchor.constraint(equalToConstant: 40),
            currencyImageView.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    private func prepareCurrencyLabel() {
        addSubview(currencyLabel)
        
        let currencyConstraints = [
            currencyLabel.leftAnchor.constraint(equalTo: currencyImageView.rightAnchor, constant: 10),
            currencyLabel.centerYAnchor.constraint(equalTo: currencyImageView.centerYAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(currencyConstraints)
    }
    
    private func prepareArrowImageView() {
        addSubview(arrowImageView)
        
        let arrowConstraints = [
            arrowImageView.leftAnchor.constraint(equalTo: currencyLabel.rightAnchor, constant: 0),
            arrowImageView.centerYAnchor.constraint(equalTo: currencyLabel.centerYAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(arrowConstraints)
    }
    
    private func prepareCurrencyNameLabel() {
        addSubview(currencyNameLabel)
        
        let currencyNameConstraints = [
            currencyNameLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 0),
            currencyNameLabel.leadingAnchor.constraint(equalTo: currencyLabel.leadingAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(currencyNameConstraints)
    }
    
    private func prepareCurrencyButton() {
        let currencyButton = UIButton(type: .custom)
        currencyButton.translatesAutoresizingMaskIntoConstraints = false
        currencyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        currencyButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(currencyButton)
        
        let currencyButtonConstraints = [
            currencyButton.topAnchor.constraint(equalTo: currencyImageView.topAnchor, constant: 0),
            currencyButton.leadingAnchor.constraint(equalTo: currencyImageView.leadingAnchor, constant: -10),
            currencyButton.trailingAnchor.constraint(equalTo: arrowImageView.trailingAnchor, constant: 10),
            currencyButton.bottomAnchor.constraint(equalTo: currencyNameLabel.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(currencyButtonConstraints)
    }
    
    private func prepareTextField() {
        textField.delegate = self
        addSubview(textField)
        
        let textFieldConstraints = [
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textField.rightAnchor.constraint(equalTo: rightAnchor, constant: -35),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            textField.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 70) / 2)
        ]
        NSLayoutConstraint.activate(textFieldConstraints)
    }
    
    @objc private func buttonAction() {

    }
}

extension CurrencyView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
