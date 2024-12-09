//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 09.12.2024.
//

import UIKit

protocol CurrencyListViewControllerDelegate: AnyObject {
    func didSelectCurrency(at index: Int, for listType: CurrencyType)
}

final class CurrencyListViewController: UIViewController {
    
    private let viewModel: CurrencyListViewModel
    weak var delegate: CurrencyListViewControllerDelegate?
    
    init(_ viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 162/255.0, green: 170/255.0, blue: 242/255.0, alpha: 1.0)
        
        prepareTableView()
    }
    
    private func prepareTableView() {
        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "CurrencyCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as! CurrencyCell
        cell.fill(with: viewModel.cellViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCurrency(at: indexPath.row, for: viewModel.listType)
        dismiss(animated: true)
    }
}
