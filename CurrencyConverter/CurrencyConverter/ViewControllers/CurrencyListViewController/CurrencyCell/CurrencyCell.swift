//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    
    private let currencyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 1.0)
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currencyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 3/255.0, green: 5/255.0, blue: 61/255.0, alpha: 0.6)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        addCurrencyImageView()
        addCurrencyCodeLabel()
        addCurrencyNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with viewModel: CurrencyCellViewModel) {
        currencyImageView.image = viewModel.currencyImage
        currencyCodeLabel.text = viewModel.currencyCode
        currencyNameLabel.text = viewModel.currencyName
    }
    
    private func addCurrencyImageView() {
        addSubview(currencyImageView)
        
        let constraints = [
            currencyImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            currencyImageView.leftAnchor.constraint(lessThanOrEqualTo: leftAnchor, constant: 20),
            currencyImageView.widthAnchor.constraint(equalToConstant: 40),
            currencyImageView.heightAnchor.constraint(equalToConstant: 40),
            currencyImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addCurrencyCodeLabel() {
        addSubview(currencyCodeLabel)
        
        let constraints = [
            currencyCodeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            currencyCodeLabel.leftAnchor.constraint(equalTo: currencyImageView.rightAnchor, constant: 10),
            currencyCodeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addCurrencyNameLabel() {
        addSubview(currencyNameLabel)
        
        let constraints = [
            currencyNameLabel.topAnchor.constraint(equalTo: currencyCodeLabel.bottomAnchor, constant: 0),
            currencyNameLabel.leftAnchor.constraint(equalTo: currencyImageView.rightAnchor, constant: 10),
            currencyNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
