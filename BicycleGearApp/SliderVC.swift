//
//  SliderVC.swift
//  BicycleGearApp
//
//  Created by George Shoemaker on 12/20/23.
//

import UIKit

class SliderVC: UIViewController {
    let outputStack = UIStackView()
    let ratioStack = KeyValueLabelStack(key: "Ratio:", value: "")
    let skidPatchStack = KeyValueLabelStack(key: "Skid Patches:", value: "")
    
    let inputStack = UIStackView()
    let ringTitleSlideView = TitleSlideView(
        title: "Chainring", value: 49, minValue: 20, maxValue: 60
    )
    let cogTitleSlideView = TitleSlideView(
        title: "Cog", value: 17, minValue: 10, maxValue: 30
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layoutOutputStack()
        layoutInputStack()
    }
    
    private func layoutOutputStack() {
        self.view.addSubview(outputStack)
        outputStack.translatesAutoresizingMaskIntoConstraints = false
        outputStack.axis = .vertical
        outputStack.alignment = .leading
        NSLayoutConstraint.activate([
            outputStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            outputStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            outputStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        outputStack.addArrangedSubview(ratioStack)
        outputStack.addArrangedSubview(skidPatchStack)
        
        ratioStack.value = "69"
    }
    
    private func layoutInputStack() {
        self.view.addSubview(inputStack)
        inputStack.translatesAutoresizingMaskIntoConstraints = false
        inputStack.axis = .vertical
        inputStack.alignment = .fill
        inputStack.backgroundColor = .cyan
        inputStack.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            inputStack.topAnchor.constraint(equalTo: outputStack.bottomAnchor, constant: 16),
            inputStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            inputStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        inputStack.addArrangedSubview(ringTitleSlideView)
        inputStack.addArrangedSubview(cogTitleSlideView)
    }
}

