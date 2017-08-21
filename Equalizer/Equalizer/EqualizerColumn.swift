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
import RxSwift

final class EqualizerColumn: UIStackView {
    
    private let offset: CGFloat = 10
    private var elements: [EqualizerComponent] = []
    private let disposeBag = DisposeBag()
    private let animationTime = 0.2
    
    
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
        var previousVolumeLevel = 0
        Observable<Int>.interval(RxTimeInterval(animationTime), scheduler: MainScheduler.instance)
            .map { _ in return (previousVolumeLevel) }
            .subscribe(onNext: { [unowned self] (previousVolume) in
                let volumeLevel = Int(arc4random_uniform(UInt32(self.elements.count * 3 / 4)) + UInt32(self.elements.count / 4))
                let singleAnimationTime = self.animationTime / Double(volumeLevel)
                if previousVolumeLevel <= volumeLevel {
                    let components = self.elements.dropLast(volumeLevel)
                    self.decreaseSequentialAnimation(elements: components, animationTime: singleAnimationTime)
                } else {
                    let components = self.elements.dropFirst(volumeLevel)
                    self.increaseSequentialAnimation(elements: components, animationTime: singleAnimationTime)
                }
                previousVolumeLevel = volumeLevel
        }).addDisposableTo(disposeBag)
    }
    
    private func decreaseSequentialAnimation(elements: ArraySlice<EqualizerComponent>, animationTime: Double) {
        guard let component = elements.first else { return }
        let rest = elements.dropFirst()
        UIView.animate(withDuration: animationTime, animations: {
            component.state = .off
        }) { _ in
            self.decreaseSequentialAnimation(elements: rest, animationTime: animationTime)
        }
    }
    
    
    private func increaseSequentialAnimation(elements: ArraySlice<EqualizerComponent>, animationTime: Double) {
        guard let component = elements.last else { return }
        let rest = elements.dropLast()
        UIView.animate(withDuration: animationTime, animations: {
            component.state = .on
        }) { _ in
            self.increaseSequentialAnimation(elements: rest, animationTime: animationTime)
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
