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
