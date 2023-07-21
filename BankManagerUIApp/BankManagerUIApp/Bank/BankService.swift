//
//  BankService.swift
//  BankManagerUIApp
//
//  Created by 1 on 2023/07/21.
//

import Foundation

struct BankService {
    var customerQueue: CustomerQueue
    private var depositBankerQueue = OperationQueue()
    private var loanBankerQueue = OperationQueue()
    private var bankingServiceTime: Double = 0.0
    private var numberOfCustomers: Int
    var processedCustomers: [Customer] = []
    var nextCustomer: Int = 1
    
    init(numberOfCustomers: Int) {
        self.numberOfCustomers = numberOfCustomers
        self.customerQueue = CustomerQueue()
        generateCustomerQueue()
    }
    
    mutating func start() {
        var isExit: Bool = false
        
        while !isExit {
            do {
                printMenu()
                guard let input = readLine(),
                      let menuChoice = Int(input) else {
                    throw InputError.invalid
                }
                
                switch menuChoice {
                case 1:
                    print(BankManagerNameSpace.startBankingService)
                    processBankWork()
                case 2:
                    isExit = true
                default:
                    throw InputError.invalid
                }
            } catch let error as InputError {
                print(error.localized)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    mutating func getNextCustomerNumber() -> Int {
        let customerNumber = nextCustomer
        nextCustomer += 1
        return customerNumber
    }
    
    private func printMenu() {
        print(BankManagerNameSpace.openBank,
              BankManagerNameSpace.closeBank,
              BankManagerNameSpace.userInput,
              separator: "\n",
              terminator: " ")
    }
    
    mutating func processBankWork() {
        let customerCount = customerQueue.count
        depositBankerQueue.maxConcurrentOperationCount = 2
        loanBankerQueue.maxConcurrentOperationCount = 1
        
        while !customerQueue.isEmpty {
            if let currentCustomer = customerQueue.dequeue() {
                let startTask = bankingServiceStartTask(currentCustomer)
                bankingServiceEndTask(currentCustomer, startTask: startTask)
            } else {
                break
            }
        }
        
        depositBankerQueue.waitUntilAllOperationsAreFinished()
        loanBankerQueue.waitUntilAllOperationsAreFinished()
        
        do {
            let workTime = try bankingServiceTimeConverter(bankingServiceTime)
            
            print(String(format: BankManagerNameSpace.summaryTaskMessage, arguments: ["\(customerCount)","\(workTime)"]))
            bankingServiceTime = 0.0
            generateCustomerQueue()
        } catch let error as NumberFormatError {
            print(error.localized)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    mutating func generateCustomerQueue() {
        for i in 1...numberOfCustomers {
            guard let bankingOperation = BankingOperations.allCases.randomElement() else {
                return
            }
            
            let customer = Customer(waitingNumber: i, bankingWork: bankingOperation)
            customerQueue.enqueue(customer: customer)
        }
        
    }
    
    mutating func bankingServiceStartTask(_ customer: Customer) -> BlockOperation {
        let startTask = BlockOperation {
            print(String(format: BankManagerNameSpace.startTaskMessage, arguments: ["\(customer.waitingNumber)", "\(customer.bankingWork.financialProductsName)"]))
            Thread.sleep(forTimeInterval: customer.bankingWork.duration)
        }
        
        switch customer.bankingWork {
        case .deposit:
            depositBankerQueue.addOperation(startTask)
        case .loan:
            loanBankerQueue.addOperation(startTask)
        }
        
        return startTask
    }
    
    mutating func bankingServiceEndTask(_ customer: Customer, startTask: BlockOperation) {
        let endTask = BlockOperation {
            print(String(format: BankManagerNameSpace.endTaskMessage, arguments: ["\(customer.waitingNumber)", "\(customer.bankingWork.financialProductsName)"]))
        }
        endTask.addDependency(startTask)
        
        switch customer.bankingWork {
        case .deposit:
            depositBankerQueue.addOperation(endTask)
        case .loan:
            loanBankerQueue.addOperation(endTask)
        }
        bankingServiceTime += customer.bankingWork.duration
    }
}
