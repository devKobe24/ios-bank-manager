//
//  Node.swift
//  BankManagerUIApp
//
//  Created by 1 on 2023/07/21.
//

final class Node<T> {
    var value: T
    var next: Node<T>?
    
    init(value: T) {
        self.value = value
    }
}
