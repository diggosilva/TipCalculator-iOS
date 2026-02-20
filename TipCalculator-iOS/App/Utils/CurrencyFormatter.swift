//
//  CurrencyFormatter.swift
//  TipCalculator-iOS
//
//  Created by Diggo Silva on 19/02/26.
//

import Foundation

enum CurrencyFormatter {
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.autoupdatingCurrent
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    static func string(from value: Double) -> String {
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    static var zero: String {
        return string(from: 0)
    }
}
