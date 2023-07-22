//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var customerButton: UIButton = {
        let button = UIButton()
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.contentHorizontalAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let waitingLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.backgroundColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let workLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.backgroundColor = .systemIndigo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "업무시간 - 00:00:000"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    private let customerLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private let bankingInProgressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private var bankService = BankService(numberOfCustomers: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollUIConstraints()
        viewUIConstraints()
        stackViewConstraint()
        timeLayout()
        workStackViewConstraint()
        customerLabelStackViewConstraint()
        bankingLabelStackViewConstraint()
        customerButton.addTarget(self, action: #selector(tapAddCustomerButton), for: .touchUpInside)
    }
    
    private func scrollUIConstraints() {
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func viewUIConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentScrollView.contentLayoutGuide.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: contentScrollView.frameLayoutGuide.widthAnchor, multiplier: 1)
        ])
    }
    
    private func stackViewConstraint() {
        containerView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(customerButton)
        buttonStackView.addArrangedSubview(resetButton)
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func timeLayout() {
        containerView.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 5),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func workStackViewConstraint() {
        containerView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(waitingLabel)
        labelStackView.addArrangedSubview(workLabel)
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 5),
            labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func customerLabelStackViewConstraint() {
        containerView.addSubview(customerLabelStackView)
        NSLayoutConstraint.activate([
            customerLabelStackView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 5),
            customerLabelStackView.trailingAnchor.constraint(equalTo: containerView.centerXAnchor),
            customerLabelStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            customerLabelStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func bankingLabelStackViewConstraint() {
        containerView.addSubview(bankingInProgressStackView)
        NSLayoutConstraint.activate([
            bankingInProgressStackView.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 5),
            bankingInProgressStackView.leadingAnchor.constraint(equalTo: containerView.centerXAnchor),
            bankingInProgressStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bankingInProgressStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    private func addNewLabel(customerName: String, loan: Bool) {
        let newLabel = UILabel()
        newLabel.text = customerName
        newLabel.textColor = .black
        newLabel.font = UIFont.systemFont(ofSize: 20)
        newLabel.textAlignment = .center
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        if loan {
            newLabel.textColor = .systemPurple
        }
        customerLabelStackView.addArrangedSubview(newLabel)
    }
    
    private func addNewWorkLabel(customerName: String, loan: Bool) {
        let newLabel = UILabel()
        newLabel.text = customerName
        newLabel.textColor = .black
        newLabel.font = UIFont.systemFont(ofSize: 20)
        newLabel.textAlignment = .center
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        if loan {
            newLabel.textColor = .systemPurple
        }
        bankingInProgressStackView.addArrangedSubview(newLabel)
    }
    
    @objc private func tapAddCustomerButton() {
        if bankService.processedCustomers.count <= 10 {
            bankService.generateCustomerQueue()
        }
        
        for _ in 1...10 {
            guard let customer = bankService.customerQueue.dequeue() else {
                break
            }
            let customerNumber = bankService.getNextCustomerNumber()
            let customerInfo = "\(customerNumber) - \(customer.bankingWork.financialProductsName)"
            let isLoan = customer.bankingWork == .loan
            addNewLabel(customerName: customerInfo, loan: isLoan)
        }
    }
}
