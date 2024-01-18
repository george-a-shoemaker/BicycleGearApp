//
//  SliderValueView.swift
//  BicycleGearApp
//
//  Created by George Shoemaker on 11/27/23.
//

/*
 Intended behaviors:
 - upon init, value and slider position are in agreement
 - you can set the value
 - when the slider slides, the value label changes and the changing value is emmitted
 
 
 
 
 */

import UIKit

class SliderValueView: UIView {
    private var value: Int {
        didSet {
            if oldValue != value {
                valueDidChange?(value)
            }
        }
    }
    
    private let slider = UISlider()
    private let valueLabel = UILabel()
    
    var valueDidChange: ((Int) -> Void)?
    
    init(value: Int, minValue: Int, maxValue: Int) {
        self.value = minValue
        super.init(frame: .zero)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(slider)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
        valueLabel.textAlignment = .right
        valueLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor),
            slider.topAnchor.constraint(equalTo: topAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor),
            slider.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -16),
            valueLabel.topAnchor.constraint(equalTo: topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        slider.addTarget(self, action: #selector(updateValue), for: .valueChanged)
        
        self.setValue(value)
    }
    
    @objc private func updateValue(_ sender: UISlider!) {
        sender.value = round(sender.value)
        value = Int(sender.value + 0.001)
        updateValueLabelText()
    }
    
    private func updateValueLabelText() {
        let text = String(value)
        DispatchQueue.main.async { [weak self] in
            self?.valueLabel.text = text
        }
    }
    
    func setValue(_ value: Int) {
        var newValue = Float(value)
        if newValue < slider.minimumValue { newValue = slider.minimumValue }
        if newValue > slider.maximumValue { newValue = slider.maximumValue }
        
        self.value = Int(newValue)
        slider.value = newValue
        updateValueLabelText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
