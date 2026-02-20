//
//  CalculatorViewController.swift
//  TipCalculator-iOS
//
//  Created by Diggo Silva on 10/02/26.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let contentView = CalculatorView()
    private let viewModel: CalculatorViewModel
    
    init(viewModel: CalculatorViewModel = CalculatorViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupDelegates()
        contentView.billAmountTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "title".localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "eraser.fill"), style: .plain, target: self, action: #selector(tappedClearUI))
    }
    
    private func setupDelegates() {
        contentView.delegate = self
    }
    
    private func setupUI() {
        contentView.updateTotalsLabels(
            totalPersonText: viewModel.totalPersonText,
            totalBillText: viewModel.totalBillText,
            totalTipText: viewModel.totalTipText,
            totalPeople: viewModel.numberOfPeople
        )
    }
    
    @objc private func tappedClearUI() {
        viewModel.clear()
        contentView.clearBillAmountTextField()
        contentView.setButtonsEnabled(false)
        setupUI()
        view.endEditing(true)
    }
}

extension CalculatorViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = textField.text,
              let stringRange = Range(range, in: currentText) else {
            return false
        }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let numbers = updatedText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let doubleValue = (Double(numbers) ?? 0) / 100.0
        
        textField.text = NumberFormatter.currency.string(from: NSNumber(value: doubleValue))
        
        viewModel.setBillAmount(doubleValue)
        contentView.setButtonsEnabled(viewModel.billAmountIsValid)
        setupUI()
        return false
    }
}

extension CalculatorViewController: CalculatorViewDelegate {
    @objc func tapped10Percent() {
        viewModel.setTipPercentage(.tenPercent)
        setupUI()
    }
    
    @objc func tapped15Percent() {
        viewModel.setTipPercentage(.fifteenPercent)
        setupUI()
    }
    
    @objc func tapped20Percent() {
        viewModel.setTipPercentage(.twentyPercent)
        setupUI()
    }
    
    @objc func tappedCustomTip() {
        showAlertCustomTip()
    }
    
    @objc func tappedDecrease() {
        viewModel.decreasePeople()
        setupUI()
    }
    
    @objc func tappedIncrease() {
        viewModel.increasePeople()
        setupUI()
    }
    
    private func showAlertCustomTip() {
        let alert = UIAlertController(title: "alert_title_label".localized, message: "alert_message_label".localized, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "placeholder".localized
            textField.keyboardType = .decimalPad
        }
        
        let confirmationAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            guard
                let self = self,
                let text = alert.textFields?.first?.text,
                let tipValue = Double(text.replacingOccurrences(of: ",", with: ".")) else { return }
            
            viewModel.setTipPercentage(.customTip(tipValue))
            setupUI()
        }
        
        alert.addAction(confirmationAction)
        alert.addAction(UIAlertAction(title: "cancel_button_title".localized, style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
}
