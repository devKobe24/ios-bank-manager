//
//  Queue.swift
//  BankManagerUIApp
//
//  Created by 1 on 2023/07/21.
//

struct Queue<T> {
    private var linkedNode: LinkedList = LinkedList<T>()
    var isEmpty: Bool {
        return linkedNode.isEmpty
    }
    var count: Int {
        return linkedNode.count
    }
    
    var peek: T? {
        return linkedNode.first
    }
    
    mutating func enqueue(_ value: T) {
        linkedNode.appendNode(value)
    }
    
    mutating func dequeue() -> T? {
        return linkedNode.removeFirst()
    }
    
    mutating func clear() {
        linkedNode.removeAll()
    }
}

