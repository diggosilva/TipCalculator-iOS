//
//  CalculatorViewModel.swift
//  TipCalculator-iOS
//
//  Created by Diggo Silva on 12/02/26.
//

import Foundation

enum TipPercentage {
    case zeroPercent
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case customTip(Double)
}

protocol CalculatorViewModelProtocol {
    var numberOfPeople: Int { get }
    
    var totalPersonText: String { get }
    var totalBillText: String { get }
    var totalTipText: String { get }
    var billAmountIsValid: Bool { get }
    
    func setBillAmount(_ amount: Double)
    func setTipPercentage(_ tip: TipPercentage)
    func decreasePeople()
    func increasePeople()
    func clear()
}

class CalculatorViewModel: CalculatorViewModelProtocol {
    
    // MARK: State (inputs)
    private var billAmount: Double = 0
    private var tipPercentage: TipPercentage = .zeroPercent
    private(set) var numberOfPeople: Int = 1
    
    // MARK: Outputs (read-only)
    private(set) var totalPersonText: String = CurrencyFormatter.zero
    private(set) var totalBillText: String = CurrencyFormatter.zero
    private(set) var totalTipText: String = CurrencyFormatter.zero
    
    private(set) var billAmountIsValid: Bool = false
    
    func setBillAmount(_ amount: Double) {
        billAmount = amount
        if billAmount == 0 {
            billAmountIsValid = false
            clear()
        } else {
            billAmountIsValid = true
            recalculate()
        }
    }
    
    func setTipPercentage(_ tip: TipPercentage) {
        tipPercentage = tip
        recalculate()
    }
    
    func decreasePeople() {
        numberOfPeople = max(1, numberOfPeople - 1)
        recalculate()
    }
    
    func increasePeople() {
        numberOfPeople += 1
        recalculate()
    }
    
    func clear() {
        billAmount = 0
        tipPercentage = .zeroPercent
        numberOfPeople = 1
        
        totalPersonText = CurrencyFormatter.zero
        totalBillText = CurrencyFormatter.zero
        totalTipText = CurrencyFormatter.zero
    }
    
    private func recalculate() {
        var tipValue: Double
        var totalBill: Double
        var totalPerPerson: Double
        
        switch tipPercentage {
        case .zeroPercent:
            tipValue = 0
        case .tenPercent:
            tipValue = billAmount * 0.10
        case .fifteenPercent:
            tipValue = billAmount * 0.15
        case .twentyPercent:
            tipValue = billAmount * 0.20
        case .customTip(let double):
            tipValue = double
        }
        
        totalBill = billAmount + tipValue
        totalPerPerson = totalBill / Double(numberOfPeople)
        
        totalPersonText = CurrencyFormatter.string(from: totalPerPerson)
        totalBillText = CurrencyFormatter.string(from: totalBill)
        totalTipText = CurrencyFormatter.string(from: tipValue)
    }
}
