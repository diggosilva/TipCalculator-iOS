//
//  String+Localized.swift
//  TipCalculator-iOS
//
//  Created by Diggo Silva on 19/02/26.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
