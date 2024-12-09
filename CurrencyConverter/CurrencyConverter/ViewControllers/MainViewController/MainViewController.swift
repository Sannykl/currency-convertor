//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by Sasha Klovak on 08.12.2024.
//

import UIKit
import Combine
import Lottie

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
    
    private let circleView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 227/255.0, green: 232/255.0, blue: 229/255.0, alpha: 1.0)
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1.0).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let reverseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(resource: .arrowUpDownFill), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "loading-animation")
        animationView.frame.size = CGSize(width: 40, height: 40)
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundColor = .red
        return animationView
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
        viewModel.$reverseButtonHidden.sink { [weak self] isHidden in
            self?.reverseButton.isHidden = isHidden
        }.store(in: &subscriptions)
        viewModel.$animationViewHidden.sink { [weak self] isHidden in
//            self?.animationView.isHidden = isHidden
        }.store(in: &subscriptions)
    }
    
    private func prepareUI() {
        view.backgroundColor = UIColor(red: 10/255.0, green: 15/255.0, blue: 46/255.0, alpha: 1.0)

        addTitle()
        addFromCurrencyView()
        addToCurrencyView()
        addCircleView()
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
        fromView.fill(with: viewModel.fromCurrencyViewModel)
        fromView.delegate = self
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
        toView.fill(with: viewModel.toCurrencyViewModel)
        toView.delegate = self
        view.addSubview(toView)
        
        let constraints = [
            toView.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: 10),
            toView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            toView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            toView.heightAnchor.constraint(equalToConstant: 120)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addCircleView() {
        view.addSubview(circleView)
        
        let constraints = [
            circleView.topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: -15),
            circleView.centerXAnchor.constraint(equalTo: fromView.centerXAnchor, constant: 0),
            circleView.heightAnchor.constraint(equalToConstant: 40),
            circleView.widthAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addReverseButton() {
        reverseButton.addTarget(self, action: #selector(reverseButtonAction), for: .touchUpInside)
        circleView.addSubview(reverseButton)
        
        let constraints = [
            reverseButton.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 0),
            reverseButton.leftAnchor.constraint(equalTo: circleView.leftAnchor, constant: 0),
            reverseButton.rightAnchor.constraint(equalTo: circleView.rightAnchor, constant: 0),
            reverseButton.bottomAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addAnimationView() {
        circleView.addSubview(animationView)
        
        let constraints = [
            circleView.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 0),
            circleView.leftAnchor.constraint(equalTo: circleView.leftAnchor, constant: 0),
            circleView.rightAnchor.constraint(equalTo: circleView.rightAnchor, constant: 0),
            circleView.bottomAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 0)
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
    
    @objc func reverseButtonAction() {
        viewModel.replaceCurencies()
    }
}

extension MainViewController: CurrencyViewDelegate {
    
    func didTapCurrencyButton(for type: CurrencyType) {
        let currencyListViewModel = viewModel.currencyListViewModel(type)
        let currencyListViewController = CurrencyListViewController(currencyListViewModel)
        currencyListViewController.delegate = self
        present(currencyListViewController, animated: true)
    }
    
    func didChangeAmount(_ text: String) {
        viewModel.didChangeCurrentAmount(text)
    }
}

extension MainViewController: CurrencyListViewControllerDelegate {
    
    func didSelectCurrency(at index: Int, for listType: CurrencyType) {
        viewModel.didSelectCurrency(at: index, listType: listType)
    }
}
