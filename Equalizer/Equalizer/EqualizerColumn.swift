//
//  EqualizerColumn.swift
//  Equalizer
//
//  Created by Bartosz Stelmaszuk on 19/08/2017.
//  Copyright © 2017 Bartosz Stelmaszuk. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class EqualizerColumn: UIStackView {
    
    enum AnimationDirection {
        case increase, decrease
    }
    
    private let rowSpacing: CGFloat
    private var elements: [EqualizerComponent] = []
    private let animationTime = 0.2
    private var previousVolumeLevel = 0
    private var timer: Timer?
    
    
    init(rowSpacing: CGFloat) {
        self.rowSpacing = rowSpacing
        super.init(frame: .zero)
        configureSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSelf() {
        axis = .vertical
        distribution = .equalSpacing
        alignment = .fill
        spacing = rowSpacing
    }
    
    func runTimer() {
        let randomCoeff = Double(arc4random_uniform(UInt32(50))) / 100
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + randomCoeff) {
            self.timer = Timer.scheduledTimer(timeInterval: (self.animationTime), target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func update() {
        let volumeLevel = Int(arc4random_uniform(UInt32(self.elements.count / 2)) + UInt32(self.elements.count / 4))
        let animationCoeff = 0.6
        if previousVolumeLevel < volumeLevel {
            let singleAnimationTime = self.animationTime * animationCoeff / Double(volumeLevel - previousVolumeLevel)
            let components = self.elements[previousVolumeLevel...volumeLevel]
            self.sequentialAnimation(direction: .decrease, elements: components, animationTime: singleAnimationTime)
        } else if previousVolumeLevel > volumeLevel {
            let singleAnimationTime = self.animationTime * animationCoeff / Double(previousVolumeLevel - volumeLevel)
            let components = self.elements[volumeLevel...previousVolumeLevel]
            self.sequentialAnimation(direction: .increase, elements: components, animationTime: singleAnimationTime)
        }
        previousVolumeLevel = volumeLevel
    }
    
    private func sequentialAnimation(
        direction: AnimationDirection,
        elements: ArraySlice<EqualizerComponent>,
        animationTime: Double
    ) {
        guard !elements.isEmpty else { return }
        let component: EqualizerComponent
        let rest: ArraySlice<EqualizerComponent>
        switch direction {
        case .increase:
            component = elements.last!
            rest = elements.dropLast()
        case .decrease:
            component = elements.first!
            rest = elements.dropFirst()
        }
        UIView.animate(withDuration: animationTime, animations: {
            switch direction {
                case .increase: component.state = .on
                case .decrease: component.state = .off
            }
        }) { _ in
            self.sequentialAnimation(direction: direction, elements: rest, animationTime: animationTime)
        }
    }
    
    override func layoutSubviews() {
        let elementsNumber = 8
        for _ in 0..<elementsNumber {
            let element = EqualizerComponent()
            element.state = .on
            elements.append(element)
            addArrangedSubview(element)
        }
    }
    
}
