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
    var totalPersonText: String { get }
    var totalBillText: String { get }
    var totalTipText: String { get }
    var billAmountIsValid: Bool { get }
    
    func setBillAmount(_ amount: Double)
    func setTipPercentage(_ tip: TipPercentage)
    func setNumberOfPeople(_ count: Int)
    func clear()
}

class CalculatorViewModel: CalculatorViewModelProtocol {
    
    // MARK: State (inputs)
    private var billAmount: Double = 0
    private var tipPercentage: TipPercentage = .zeroPercent
    private var numberOfPeople: Int = 1
    
    // MARK: Outputs (read-only)
    private(set) var totalPersonText: String = "R$0,00"
    private(set) var totalBillText: String = "R$0,00"
    private(set) var totalTipText: String = "R$0,00"
    
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
    
    func setNumberOfPeople(_ count: Int) {
        numberOfPeople = count
        recalculate()
    }
    
    func clear() {
        billAmount = 0
        tipPercentage = .zeroPercent
        numberOfPeople = 1
        
        totalPersonText = "R$0,00"
        totalBillText = "R$0,00"
        totalTipText = "R$0,00"
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
        
        totalPersonText = formatCurrency(totalPerPerson)
        totalBillText = formatCurrency(totalBill)
        totalTipText = formatCurrency(tipValue)
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.usesGroupingSeparator = true
        return formatter.string(from: NSNumber(value: value)) ?? "R$0,00"
    }
}
