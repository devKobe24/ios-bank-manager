//
//  BankingServiceTimeConverter.swift
//  BankManagerUIApp
//
//  Created by 1 on 2023/07/21.
//

import Foundation

func bankingServiceTimeConverter(_ bankingServiceTime: Double) throws -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.roundingMode = .halfUp
    
    guard let numberFormatted = numberFormatter.string(for: bankingServiceTime) else {
        print(NumberFormatError.convertedString.localized)
        throw NumberFormatError.convertedString
    }
    
    return numberFormatted
}
