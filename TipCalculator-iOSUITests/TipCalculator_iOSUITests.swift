//
//  TipCalculator_iOSUITests.swift
//  TipCalculator-iOSUITests
//
//  Created by Diggo Silva on 06/05/26.
//

import XCTest

final class TipCalculator_iOSUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testInitialState() throws {
        XCTAssertEqual(app.staticTexts[DSIdentifiers.totalBillValueLabel].label, "R$ 0,00")
        XCTAssertEqual(app.staticTexts[DSIdentifiers.totalPerPersonValueLabel].label, "R$ 0,00")
        XCTAssertEqual(app.staticTexts[DSIdentifiers.tipAmountValueLabel].label, "R$ 0,00")
        XCTAssertEqual(app.staticTexts[DSIdentifiers.peopleCountValueLabel].label, "1")
        
        XCTAssertFalse(app.buttons[DSIdentifiers.tip10PercentButton].isEnabled)
    }
    
    func testFullCalculationFlow() throws {
        let billAmountTextField = app.textFields[DSIdentifiers.billAmountTextField]
        XCTAssertTrue(billAmountTextField.exists)
        
        // Inserir 100,00 na textfield (Digitando 10000 devido à máscara de moeda)
        billAmountTextField.tap()
        billAmountTextField.typeText("10000")
        
        // Seleciona 10% de gorjeta
        app.buttons[DSIdentifiers.tip10PercentButton].tap()
        
        // Verifica cálculos para 1 pessoa
        XCTAssertTrue(app.staticTexts[DSIdentifiers.tipAmountValueLabel].label.contains("10,00"))
        XCTAssertTrue(app.staticTexts[DSIdentifiers.totalBillValueLabel].label.contains("110,00"))
        XCTAssertTrue(app.staticTexts[DSIdentifiers.totalPerPersonValueLabel].label.contains("110,00"))
        
        // Divide para 2 pessoas
        app.staticTexts[DSIdentifiers.totalPerPersonValueLabel].tap()
        app.buttons[DSIdentifiers.increasePeopleButton].tap()
        XCTAssertEqual(app.staticTexts[DSIdentifiers.peopleCountValueLabel].label, "2")
        XCTAssertTrue(app.staticTexts[DSIdentifiers.totalPerPersonValueLabel].label.contains("55,00"))
        
        // Testa decremento de pessoas (não deve baixar de 1)
        app.buttons[DSIdentifiers.decreasePeopleButton].tap()
        app.buttons[DSIdentifiers.decreasePeopleButton].tap()
        XCTAssertEqual(app.staticTexts[DSIdentifiers.peopleCountValueLabel].label, "1")
    }
    
    func testCustomTipAlert() throws {
        let billAmountTextField = app.textFields[DSIdentifiers.billAmountTextField]
        XCTAssertTrue(billAmountTextField.exists)
        
        billAmountTextField.tap()
        billAmountTextField.typeText("10000")
        
        // Seleciona gorjeta custom pra exibir o alerta
        app.buttons[DSIdentifiers.customTipButton].tap()
        
        let alert = app.alerts[DSIdentifiers.customTipAlert]
        XCTAssertTrue(alert.exists)
        
        let alertTextField = alert.textFields[DSIdentifiers.customTipTextField]
        alertTextField.typeText("25") // 25 reais de gorjeta fixa
        alert.buttons.element(boundBy: 1).tap() // Clica no OK (segundo botão do alerta)
        
        XCTAssertTrue(app.staticTexts[DSIdentifiers.tipAmountValueLabel].label.contains("25,00"))
        XCTAssertTrue(app.staticTexts[DSIdentifiers.totalBillValueLabel].label.contains("125,00"))
    }
    
    func testClearButton() throws {
        let billAmountTextField = app.textFields[DSIdentifiers.billAmountTextField]
        XCTAssertTrue(billAmountTextField.exists)
        
        billAmountTextField.tap()
        billAmountTextField.typeText("25000")
        
        // Clica no botão de limpar (borracha) na Navigation Bar
        app.buttons[DSIdentifiers.clearButton].tap()
        
        XCTAssertEqual(app.staticTexts[DSIdentifiers.totalBillValueLabel].label, "R$ 0,00")
        XCTAssertEqual(app.staticTexts[DSIdentifiers.totalPerPersonValueLabel].label, "R$ 0,00")
        XCTAssertEqual(app.staticTexts[DSIdentifiers.tipAmountValueLabel].label, "R$ 0,00")
        XCTAssertEqual(app.staticTexts[DSIdentifiers.peopleCountValueLabel].label, "1")
        
        XCTAssertFalse(app.buttons[DSIdentifiers.tip10PercentButton].isEnabled)
    }
}
