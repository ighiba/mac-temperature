//
//  TemperatureStatusBarRow.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 10.08.2023.
//

import Cocoa

private let titleWidthMultiplier: CGFloat = 0.8

class TemperatureStatusBarRow: NSView {
    
    private(set) var titleTextField: NSTextField = NSTextField(labelWithString: "Unknown")
    private(set) var valueTextField: NSTextField = NSTextField(labelWithString: "0.0")
    
    private(set) var key: String
    
    init(key: String, title: String, value: Float) {
        self.key = key
        super.init(frame: .zero)
        self.titleTextField.stringValue = title
        self.valueTextField.stringValue = "\(value)"
        self.setupViews()
        self.setupLayout()
    }
    
    convenience init(data: TemperatureData) {
        self.init(key: data.id, title: data.title, value: data.temperature.value)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleTextField)
        addSubview(valueTextField)
    }
    
    func setupLayout() {
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        valueTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleTextField.topAnchor.constraint(equalTo: topAnchor),
            titleTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: titleWidthMultiplier),
            
            valueTextField.leadingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            valueTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueTextField.topAnchor.constraint(equalTo: topAnchor),
            valueTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
