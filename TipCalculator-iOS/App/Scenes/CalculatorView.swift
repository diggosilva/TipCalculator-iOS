//
//  CalculatorView.swift
//  TipCalculator-iOS
//
//  Created by Diggo Silva on 11/02/26.
//

import UIKit

protocol CalculatorViewDelegate: AnyObject {
    func tapped10Percent()
    func tapped15Percent()
    func tapped20Percent()
    func tappedCustomTip()
    func tappedDecrease()
    func tappedIncrease()
}

final class CalculatorView: UIView {
    
    weak var delegate: CalculatorViewDelegate?
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .tertiarySystemBackground
        return view
    }()
    
    // MARK: - Total per person
    lazy var totalPerPersonTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Por pessoa"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    lazy var totalPerPersonValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 0,00"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        return view
    }()
    
    // MARK: - Total bill
    lazy var totalBillTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total da conta"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        return label
    }()
    
    lazy var totalBillValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 0,00"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    
    // MARK: - Tip
    lazy var tipAmountTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Gorjeta"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        return label
    }()
    
    lazy var tipAmountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 0,00"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Bill amount input
    lazy var billAmountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Valor da conta"
        textField.text = "R$ 0,00"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 24)
        textField.backgroundColor = .tertiarySystemBackground
        return textField
    }()
    
    // MARK: - Tip buttons
    lazy var tip10PercentButton = buildButton(title: "10%", target: self, action: #selector(tapped10Percent))
    lazy var tip15PercentButton = buildButton(title: "15%", target: self, action: #selector(tapped15Percent))
    lazy var tip20PercentButton = buildButton(title: "20%", target: self, action: #selector(tapped20Percent))
    
    // MARK: - Custom tip
    lazy var customTipButton = buildButton(title: "Gorjeta personalizada", target: self, action: #selector(tappedCustomTip))
    
    // MARK: - People count
    lazy var peopleCountTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Número de pessoas"
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var decreasePeopleButton = buildButton(title: "-", target: self, action: #selector(tappedDecrease))
    lazy var increasePeopleButton = buildButton(title: "+", target: self, action: #selector(tappedIncrease))
    
    lazy var peopleCountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1"
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.backgroundColor = .tertiarySystemBackground
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
        setButtonsEnabled(false)
    }
    
    private func setupHierarchy() {
        addSubview(cardView)
        
        cardView.addSubviews(
            totalPerPersonTitleLabel, totalPerPersonValueLabel, separator,
            totalBillTitleLabel, totalBillValueLabel, tipAmountTitleLabel, tipAmountValueLabel)
        
        addSubviews(billAmountTextField,
                    tip20PercentButton, tip15PercentButton, tip10PercentButton,
                    customTipButton,
                    peopleCountTitleLabel,
                    decreasePeopleButton, increasePeopleButton, peopleCountValueLabel)
    }
    
    private func setupConstraints() {
        // Card
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
            totalPerPersonTitleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            totalPerPersonTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            totalPerPersonTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            totalPerPersonValueLabel.topAnchor.constraint(equalTo: totalPerPersonTitleLabel.bottomAnchor, constant: 10),
            totalPerPersonValueLabel.leadingAnchor.constraint(equalTo: totalPerPersonTitleLabel.leadingAnchor),
            totalPerPersonValueLabel.trailingAnchor.constraint(equalTo: totalPerPersonTitleLabel.trailingAnchor),
            
            separator.topAnchor.constraint(equalTo: totalPerPersonValueLabel.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: totalPerPersonTitleLabel.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: totalPerPersonTitleLabel.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 2),
            
            totalBillTitleLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 5),
            totalBillTitleLabel.leadingAnchor.constraint(equalTo: totalPerPersonTitleLabel.leadingAnchor),
            
            totalBillValueLabel.topAnchor.constraint(equalTo: totalBillTitleLabel.bottomAnchor, constant: 10),
            totalBillValueLabel.leadingAnchor.constraint(equalTo: totalBillTitleLabel.leadingAnchor),
            totalBillValueLabel.trailingAnchor.constraint(equalTo: tipAmountValueLabel.leadingAnchor, constant: -10),
            totalBillValueLabel.widthAnchor.constraint(lessThanOrEqualTo: cardView.widthAnchor, multiplier: 0.45),
            
            tipAmountTitleLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 5),
            tipAmountTitleLabel.trailingAnchor.constraint(equalTo: totalPerPersonTitleLabel.trailingAnchor),
            
            tipAmountValueLabel.topAnchor.constraint(equalTo: tipAmountTitleLabel.bottomAnchor, constant: 10),
            tipAmountValueLabel.trailingAnchor.constraint(equalTo: tipAmountTitleLabel.trailingAnchor),
            tipAmountValueLabel.widthAnchor.constraint(lessThanOrEqualTo: cardView.widthAnchor, multiplier: 0.45),
        ])
        
        // Inputs
        NSLayoutConstraint.activate([
            billAmountTextField.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 40),
            billAmountTextField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            billAmountTextField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            billAmountTextField.heightAnchor.constraint(equalToConstant: 60),
            
            tip20PercentButton.topAnchor.constraint(equalTo: billAmountTextField.bottomAnchor, constant: 40),
            tip20PercentButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            tip20PercentButton.widthAnchor.constraint(equalToConstant: 80),
            tip20PercentButton.heightAnchor.constraint(equalToConstant: 60),
            
            tip15PercentButton.topAnchor.constraint(equalTo: tip20PercentButton.topAnchor),
            tip15PercentButton.trailingAnchor.constraint(equalTo: tip20PercentButton.leadingAnchor, constant: -20),
            tip15PercentButton.widthAnchor.constraint(equalTo: tip20PercentButton.widthAnchor),
            tip15PercentButton.heightAnchor.constraint(equalTo: tip20PercentButton.heightAnchor),
            
            tip10PercentButton.topAnchor.constraint(equalTo: tip15PercentButton.topAnchor),
            tip10PercentButton.trailingAnchor.constraint(equalTo: tip15PercentButton.leadingAnchor, constant: -20),
            tip10PercentButton.widthAnchor.constraint(equalTo: tip20PercentButton.widthAnchor),
            tip10PercentButton.heightAnchor.constraint(equalTo: tip20PercentButton.heightAnchor),
            
            customTipButton.topAnchor.constraint(equalTo: tip10PercentButton.bottomAnchor, constant: 20),
            customTipButton.leadingAnchor.constraint(equalTo: tip10PercentButton.leadingAnchor),
            customTipButton.trailingAnchor.constraint(equalTo: tip20PercentButton.trailingAnchor),
            customTipButton.heightAnchor.constraint(equalTo: tip20PercentButton.heightAnchor),
            
            peopleCountTitleLabel.topAnchor.constraint(equalTo: customTipButton.bottomAnchor, constant: 20),
            peopleCountTitleLabel.leadingAnchor.constraint(equalTo: tip10PercentButton.leadingAnchor),
            peopleCountTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            decreasePeopleButton.topAnchor.constraint(equalTo: peopleCountTitleLabel.bottomAnchor, constant: 5),
            decreasePeopleButton.leadingAnchor.constraint(equalTo: tip10PercentButton.leadingAnchor),
            decreasePeopleButton.trailingAnchor.constraint(equalTo: tip10PercentButton.trailingAnchor),
            decreasePeopleButton.heightAnchor.constraint(equalTo: tip20PercentButton.heightAnchor),
            
            peopleCountValueLabel.topAnchor.constraint(equalTo: decreasePeopleButton.topAnchor),
            peopleCountValueLabel.leadingAnchor.constraint(equalTo: decreasePeopleButton.trailingAnchor, constant: -8),
            peopleCountValueLabel.trailingAnchor.constraint(equalTo: increasePeopleButton.leadingAnchor, constant: 8),
            peopleCountValueLabel.heightAnchor.constraint(equalTo: tip20PercentButton.heightAnchor),
            
            increasePeopleButton.topAnchor.constraint(equalTo: decreasePeopleButton.topAnchor),
            increasePeopleButton.leadingAnchor.constraint(equalTo: tip20PercentButton.leadingAnchor),
            increasePeopleButton.trailingAnchor.constraint(equalTo: tip20PercentButton.trailingAnchor),
            increasePeopleButton.heightAnchor.constraint(equalTo: tip20PercentButton.heightAnchor),
        ])
    }
    
    private func setupConfigurations() {
        backgroundColor = .secondarySystemBackground
        applyShadow(view: cardView)
    }
    
    func setButtonsEnabled(_ isEnabled: Bool) {
        if !isEnabled {
            [tip10PercentButton, tip15PercentButton, tip20PercentButton, customTipButton, decreasePeopleButton, increasePeopleButton].forEach { $0.isEnabled = false }
            [tip10PercentButton, tip15PercentButton, tip20PercentButton, customTipButton, decreasePeopleButton, increasePeopleButton].forEach { $0.alpha = 0.5 }
            [tip10PercentButton, tip15PercentButton, tip20PercentButton, customTipButton, decreasePeopleButton, increasePeopleButton].forEach { $0.backgroundColor = .lightGray }
            peopleCountValueLabel.text = "1"
        } else {
            [tip10PercentButton, tip15PercentButton, tip20PercentButton, customTipButton, decreasePeopleButton, increasePeopleButton].forEach { $0.isEnabled = true }
            [tip10PercentButton, tip15PercentButton, tip20PercentButton, customTipButton, decreasePeopleButton, increasePeopleButton].forEach { $0.alpha = 1 }
            [tip10PercentButton, tip15PercentButton, tip20PercentButton, customTipButton, decreasePeopleButton, increasePeopleButton].forEach { $0.backgroundColor = .systemIndigo }
        }
    }
}

//MARK: Helpers
extension CalculatorView {
    @objc func tapped10Percent() {
        delegate?.tapped10Percent()
    }
    
    @objc func tapped15Percent() {
        delegate?.tapped15Percent()
    }
    
    @objc func tapped20Percent() {
        delegate?.tapped20Percent()
    }
    
    @objc func tappedCustomTip() {
        delegate?.tappedCustomTip()
    }
    
    @objc func tappedDecrease() {
        delegate?.tappedDecrease()
    }
    
    @objc func tappedIncrease() {
        delegate?.tappedIncrease()
    }
    
    func updateTotalsLabels(totalPersonText: String, totalBillText: String, totalTipText: String, totalPeople: Int) {
        totalPerPersonValueLabel.text = totalPersonText
        totalBillValueLabel.text = totalBillText
        tipAmountValueLabel.text = totalTipText
        peopleCountValueLabel.text = "\(totalPeople)"
    }
    
    func updatePeopleCount(_ count: Int) {
        peopleCountValueLabel.text = "\(count)"
    }
}
