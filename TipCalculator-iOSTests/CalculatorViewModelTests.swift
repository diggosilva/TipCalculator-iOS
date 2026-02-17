//
//  TipCalculator_iOSTests.swift
//  TipCalculator-iOSTests
//
//  Created by Diggo Silva on 16/02/26.
//

import XCTest
@testable import TipCalculator_iOS

final class CalculatorViewModelTests: XCTestCase {
    
    private var sut: CalculatorViewModel!
    
    override func setUp() {
        super.setUp()
        sut = CalculatorViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_initialState_shouldBeCorrect() {
        XCTAssertEqual(sut.numberOfPeople, 1)
        XCTAssertEqual(sut.billAmountIsValid, false)
        XCTAssertEqual(sut.totalBillText, .defaultCurrencyValue)
        XCTAssertEqual(sut.totalTipText, .defaultCurrencyValue)
        XCTAssertEqual(sut.totalPersonText, .defaultCurrencyValue)
    }
}
