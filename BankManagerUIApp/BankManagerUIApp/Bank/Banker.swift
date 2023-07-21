//
//  Banker.swift
//  BankManagerUIApp
//
//  Created by 1 on 2023/07/21.
//

struct Banker {
    private var numberOfBankers: Int
    
    init(numberOfBankers: Int) {
        self.numberOfBankers = numberOfBankers
    }
    
    func processBankerTask(customer: Customer) {
        print("\(customer.waitingNumber)번 고객 업무 완료")
    }
}

