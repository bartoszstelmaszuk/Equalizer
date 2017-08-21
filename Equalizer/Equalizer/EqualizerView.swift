//
// Created by Bartosz Stelmaszuk on 19/08/2017.
// Copyright (c) 2017 Bartosz Stelmaszuk. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class EqualizerView: UIStackView {
    
    private var columns: [EqualizerColumn] = []
    private let offset: CGFloat = 10

    init() {
        super.init(frame: .zero)
        configureSelf()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSelf() {
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .fill
        spacing = offset
        
    }
    
    override func layoutSubviews() {
        let columnsNumber = Int(frame.width / (EqualizerComponent.defaultWidth + offset))
        for _ in 0..<columnsNumber {
            let element = EqualizerColumn()
            columns.append(element)
            element.snp.makeConstraints { (maker) in
                maker.width.equalTo(EqualizerComponent.defaultWidth + offset)
            }
            addArrangedSubview(element)
        }
    }
    
    func runTimers() {
        columns.forEach { $0.runTimer() }
    }
}
