//
//  Helpers.swift
//  TipCalculator-iOS
//
//  Created by Diggo Silva on 11/02/26.
//

import UIKit

func buildButton(title: String, target: Any?, action: Selector) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    button.backgroundColor = .systemIndigo
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 8
    button.titleLabel?.textAlignment = .center
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.minimumScaleFactor = 0.6
    button.addTarget(target, action: action, for: .touchUpInside)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.titleLabel?.minimumScaleFactor = 0.6
    return button
}

func applyShadow(view: UIView) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 5, height: 5)
    view.layer.shadowOpacity = 0.25
    view.layer.shadowRadius = 5.0
}

func buildCardView() -> UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.cornerRadius = 16
    view.backgroundColor = .tertiarySystemBackground
    return view
}

func buildTitleLabel(text: String, textColor: UIColor = .label, textAlignment: NSTextAlignment = .left) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = .systemFont(ofSize: 14)
    label.textColor = textColor
    label.textAlignment = textAlignment
    return label
}

func buildValueLabel(text: String, textColor: UIColor = .label, textAlignment: NSTextAlignment = .left, font: UIFont? = nil, backgroundColor: UIColor? = .clear) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.font = font
    label.textColor = textColor
    label.textAlignment = textAlignment
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.6
    label.backgroundColor = backgroundColor
    return label
}

func buildSeparator() -> UIView {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .separator
    return view
}

func buildTextField() -> UITextField {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.text = CurrencyFormatter.zero
    textField.keyboardType = .decimalPad
    textField.borderStyle = .roundedRect
    textField.font = .systemFont(ofSize: 24)
    textField.backgroundColor = .tertiarySystemBackground
    return textField
}
