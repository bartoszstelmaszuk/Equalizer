//
// Created by Bartosz Stelmaszuk on 19/08/2017.
// Copyright (c) 2017 Bartosz Stelmaszuk. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class EqualizerView: UIStackView {
    
    private var columns: [EqualizerColumn] = []
    private let columnSpacing: CGFloat
    private let rowSpacing: CGFloat

    init(rowSpacing: CGFloat, columnSpacing: CGFloat) {
        self.rowSpacing = rowSpacing
        self.columnSpacing = columnSpacing
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
        spacing = columnSpacing
        
    }
    
    override func layoutSubviews() {
        let columnsNumber = 8
        for _ in 0..<columnsNumber {
            let element = EqualizerColumn(rowSpacing: rowSpacing)
            columns.append(element)
            element.snp.makeConstraints { (maker) in
                maker.width.equalTo(EqualizerComponent.defaultWidth)
            }
            addArrangedSubview(element)
        }
    }
    
    func runTimers() {
        columns.forEach { $0.runTimer() }
    }
}
