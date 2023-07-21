//
//  CustomerQueue.swift
//  BankManagerUIApp
//
//  Created by 1 on 2023/07/21.
//

struct CustomerQueue {
    private var customers: Queue<Customer>
    
    init() {
        self.customers = Queue<Customer>()
    }
    
    mutating func enqueue(customer: Customer) {
        customers.enqueue(customer)
    }
    
    mutating func dequeue() -> Customer? {
        return customers.dequeue()
    }
    
    var count: Int {
        return customers.count
    }
    
    var isEmpty: Bool {
        return customers.isEmpty
    }
    
    mutating func clear() {
        return customers.clear()
    }
    
    func allCustomers() -> [Customer] {
        var tempQueue = self
        var allCustomers = [Customer]()
        while let customer = tempQueue.dequeue() {
            allCustomers.append(customer)
        }
        return allCustomers
    }
}

