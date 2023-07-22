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
    
    private var waitingCustomers: [UILabel] = []
    private var bankingInProgressCustomers: [UILabel] = []
    
    private var timer: Timer?
    private var totalTime: TimeInterval = 0
    private var lastStartTime: Date?
    private var isTimerRun: Bool = false
    
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
        resetButton.addTarget(self, action: #selector(timerReset), for: .touchUpInside)
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
        
    private func startBankingWork() {
        guard let customer = bankService.customerQueue.dequeue() else { return }
        
        let customerNumber = bankService.getNextCustomerNumber()
        let customerInfo = "\(customerNumber) - \(customer.bankingWork.financialProductsName)"
        let isLoan = customer.bankingWork == .loan
        addNewLabel(customerName: customerInfo, loan: isLoan)
        waitingCustomers.append(customerLabelStackView.arrangedSubviews.last as! UILabel)
        
        startTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + customer.bankingWork.duration) { [weak self] in
            guard let self = self else { return }
            
            let customerLabel = self.waitingCustomers.first
            self.waitingCustomers.removeFirst()
            self.bankingInProgressCustomers.append(customerLabel!)
            self.customerLabelStackView.removeArrangedSubview(customerLabel!)
            self.bankingInProgressStackView.addArrangedSubview(customerLabel!)
            
            //여기서 한번더해야지 사라짐
            DispatchQueue.main.asyncAfter(deadline: .now() + customer.bankingWork.duration) {
                customerLabel?.removeFromSuperview()
                self.bankingInProgressCustomers.removeFirst()
                self.stopTimer()
            }
        }
    }
    
    @objc private func tapAddCustomerButton() {
        if bankService.processedCustomers.count < 11 {
            bankService.generateCustomerQueue()
        }
        for _ in 1...10 {
            startBankingWork()
        }
    }
}


extension ViewController {
    private func startTimer() {
        guard !isTimerRun else { return }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        lastStartTime = Date()
        isTimerRun = true
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        lastStartTime = nil
        isTimerRun = false
    }
    private func customerQueueReset() {
        bankService.customerQueue.clear()
        waitingCustomers.removeAll()
        bankingInProgressCustomers.removeAll()
    }
    
    @objc func timerReset() {
        stopTimer()
        customerQueueReset()
        bankService.nextCustomer = 1
        totalTime = 0
        timerLabel.text = "업무시간 - 00:00:000"
    }
    
    @objc private func updateTimerLabel() {
        guard let lastStartTime = lastStartTime else {
            return
        }
        
        let currentTime = Date()
        totalTime += currentTime.timeIntervalSince(lastStartTime)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.zeroFormattingBehavior = .pad
        let formattedTime = formatter.string(from: totalTime) ?? "00:00:000"
        timerLabel.text = "업무시간 - \(formattedTime)"
    }
}
