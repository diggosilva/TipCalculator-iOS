//
//  CalculatorViewController.swift
//  TipCalculator-iOS
//
//  Created by Diggo Silva on 10/02/26.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let contentView = CalculatorView()
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupDelegates()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Calculadora de Gorjetas"
        
    }
    
    private func setupDelegates() {
        contentView.delegate = self
    }
    
    var counter = 1
}

extension CalculatorViewController: CalculatorViewDelegate {
    @objc func textFieldDidChange() {
        if let text = contentView.billAmountTextField.text, !text.isEmpty {
            print("DEBUG: Text is not empty")
        } else {
            print("DEBUG: Text is empty")
        }
    }
    
    @objc func tapped10Percent() {
        print("DEBUG: Clicou 10%")
    }
    
    @objc func tapped15Percent() {
        print("DEBUG: Clicou 15%")
    }
    
    @objc func tapped20Percent() {
        print("DEBUG: Clicou 20%")
    }
    
    @objc func tappedCustomTip() {
        print("DEBUG: Clicou Custom Tip")
    }
    
    @objc func tappedDecrease() {
        if counter == 1 { return }
        counter -= 1
        contentView.peopleCountValueLabel.text = "\(counter)"
    }
    
    @objc func tappedIncrease() {
        counter += 1
        contentView.peopleCountValueLabel.text = "\(counter)"
    }
}
