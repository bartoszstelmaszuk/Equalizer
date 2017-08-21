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
    
    private let offset: CGFloat = 10
    private var elements: [EqualizerComponent] = []
    private let animationTime = 0.1
    private var previousVolumeLevel = 0
    private var timer: Timer?
    private var tickNumber = 0
    
    
    init() {
        super.init(frame: .zero)
        configureSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSelf() {
        axis = .vertical
        distribution = .equalSpacing
        alignment = .center
        spacing = offset
    }
    
    func runTimer() {
        let randomCoeff = Double(arc4random_uniform(UInt32(5))) / 10
        timer = Timer.scheduledTimer(timeInterval: (animationTime + randomCoeff), target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc private func update() {
        let volumeLevel: Int
        if tickNumber % 2 == 0 {
            volumeLevel = Int(arc4random_uniform(UInt32(self.elements.count / 5)) + UInt32(self.elements.count / 4))
        } else {
            volumeLevel = Int(arc4random_uniform(UInt32(self.elements.count / 5)) + UInt32(self.elements.count / 2))
        }
        if previousVolumeLevel < volumeLevel {
            let singleAnimationTime = self.animationTime / Double(volumeLevel - previousVolumeLevel)
            let components = self.elements[previousVolumeLevel...volumeLevel]
            self.sequentialAnimation(direction: .decrease, elements: components, animationTime: singleAnimationTime)
        } else if previousVolumeLevel > volumeLevel {
            let singleAnimationTime = self.animationTime / Double(previousVolumeLevel - volumeLevel)
            let components = self.elements[volumeLevel...previousVolumeLevel]
            self.sequentialAnimation(direction: .increase, elements: components, animationTime: singleAnimationTime)
        }
        tickNumber = tickNumber + 1
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
        let elementsNumber = Int(frame.height / (EqualizerComponent.defaultHeight + offset))
        for _ in 0..<elementsNumber {
            let element = EqualizerComponent()
            element.state = .on
            elements.append(element)
            addArrangedSubview(element)
        }
    }
    
}
