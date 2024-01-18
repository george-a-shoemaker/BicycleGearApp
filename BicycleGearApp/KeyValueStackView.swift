//
//  KeyValueStackView.swift
//  BicycleGearApp
//
//  Created by George Shoemaker on 11/26/23.
//

import UIKit

class TitleSlideView: UIView {
    let title : String
    let titleLabel = UILabel()
    
    let sliderValueView : SliderValueView
    init(title: String, value: Int, minValue: Int, maxValue: Int) {
        self.title = title
        self.sliderValueView = SliderValueView(value: value, minValue: minValue, maxValue: maxValue)
        super.init(frame: .zero)
        
        //add subviews & tamic
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        sliderValueView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sliderValueView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            sliderValueView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            sliderValueView.topAnchor.constraint(equalTo: topAnchor),
            sliderValueView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sliderValueView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        titleLabel.text = title
    
        sliderValueView.setValue(value)
        
        //configure subviews
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class KeyValueLabelStack: UIStackView {
    
    let key : String
    var value : String {
        didSet {
            valueLabel.text = value
        }
    }
    
    private let keyLabel = UILabel()
    private let valueLabel = UILabel()
    
    init(key: String, value: String) {
        
        self.key = key
        keyLabel.text = key
        
        
        self.value = value
        super.init(frame: .zero)
        
        self.spacing = 8
        self.axis = .horizontal
        
        addArrangedSubview(keyLabel)
        addArrangedSubview(valueLabel)
        
        keyLabel.font = .systemFont(ofSize: 20)
        valueLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
