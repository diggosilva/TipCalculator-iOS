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
    
    // MARK: - Initial State
    
    func test_initialState_shouldBeCorrect() {
        XCTAssertEqual(sut.numberOfPeople, 1)
        XCTAssertFalse(sut.billAmountIsValid)
        XCTAssertEqual(sut.totalBillText, .defaultCurrencyValue)
        XCTAssertEqual(sut.totalTipText, .defaultCurrencyValue)
        XCTAssertEqual(sut.totalPersonText, .defaultCurrencyValue)
    }
    
    // MARK: - Bill Amount
    
    func test_setBillAmount_zero_shouldClearAndInvalidate() {
        sut.setBillAmount(0.0)
        
        XCTAssertEqual(sut.numberOfPeople, 1)
        XCTAssertFalse(sut.billAmountIsValid)
        XCTAssertEqual(sut.totalBillText, .defaultCurrencyValue)
        XCTAssertEqual(sut.totalTipText, .defaultCurrencyValue)
        XCTAssertEqual(sut.totalPersonText, .defaultCurrencyValue)
    }
    
    func test_setBillAmount_valid_shouldValidateBill() {
        sut.setBillAmount(100.0)
        XCTAssertTrue(sut.billAmountIsValid)
    }
    
    func test_tenPercentTip_shouldCalculateCorrectly() {
        sut.setBillAmount(100.0)
        sut.setTipPercentage(.tenPercent)
        
        XCTAssertTrue(sut.totalBillText.contains("110"))
        XCTAssertTrue(sut.totalTipText.contains("10"))
        XCTAssertTrue(sut.totalPersonText.contains("110"))
    }
    
    func test_fifteenPercentTip_shouldCalculateCorrectly() {
        sut.setBillAmount(100.0)
        sut.setTipPercentage(.fifteenPercent)
        
        XCTAssertTrue(sut.totalBillText.contains("115"))
        XCTAssertTrue(sut.totalTipText.contains("15"))
        XCTAssertTrue(sut.totalPersonText.contains("115"))
    }
    
    func test_twentyPercentTip_shouldCalculateCorrectly() {
        sut.setBillAmount(100.0)
        sut.setTipPercentage(.twentyPercent)
        
        XCTAssertTrue(sut.totalBillText.contains("120"))
        XCTAssertTrue(sut.totalTipText.contains("20"))
        XCTAssertTrue(sut.totalPersonText.contains("120"))
    }
    
    func test_customTip_shouldUseExactValue() {
        sut.setBillAmount(100.0)
        sut.setTipPercentage(.customTip(25.0))
        
        XCTAssertTrue(sut.totalBillText.contains("125"))
        XCTAssertTrue(sut.totalTipText.contains("25"))
        XCTAssertTrue(sut.totalPersonText.contains("125"))
    }
    
    // MARK: - People
    
    func test_increasePeople_shouldIncreaseCount() {
        sut.increasePeople()
        XCTAssertEqual(sut.numberOfPeople, 2)
    }
    
    func test_decreasePeople_shouldIncreaseCount() {
        sut.increasePeople()
        sut.increasePeople()
        sut.decreasePeople()
        
        XCTAssertEqual(sut.numberOfPeople, 2)
    }
    
    func test_splitBetweenTwoPeople_shouldDivideCorrectly() {
        sut.setBillAmount(100.0)
        sut.setTipPercentage(.zeroPercent)
        sut.increasePeople()
        
        XCTAssertEqual(sut.totalPersonText, "R$ 50,00")
    }
    
    // MARK: - Clear
    
    func test_clear_shouldResetAllValues() {
        sut.setBillAmount(100.0)
        sut.setTipPercentage(.twentyPercent)
        sut.increasePeople()
        
        sut.clear()
        
        XCTAssertTrue(sut.billAmountIsValid)
        XCTAssertEqual(sut.numberOfPeople, 1)
        
        XCTAssertTrue(sut.totalBillText.contains(.defaultCurrencyValue))
        XCTAssertTrue(sut.totalTipText.contains(.defaultCurrencyValue))
        XCTAssertTrue(sut.totalPersonText.contains(.defaultCurrencyValue))
    }
}
