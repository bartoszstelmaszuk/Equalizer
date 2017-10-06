//
// Created by Bartosz Stelmaszuk on 19/08/2017.
// Copyright (c) 2017 Bartosz Stelmaszuk. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class MainView: UIView {
    
    private let rowSpacing: CGFloat = 1.13
    private let columnSpacing: CGFloat = 3.4
    private let columnsNumber: Int = 8
    private let rowsNumber: Int = 8
    private let equalizerView: EqualizerView

    init() {
        equalizerView = EqualizerView(
            rowSpacing: rowSpacing,
            columnSpacing: columnSpacing,
            columnsNumber: columnsNumber,
            rowsNumber: rowsNumber
        )
        super.init(frame: .zero)
        configureSelf()
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSelf() {
        backgroundColor = .red
    }

    private func configureConstraints() {
        addSubview(equalizerView)
        equalizerView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalTo(CGFloat(rowsNumber + 1) * EqualizerComponent.defaultHeight + CGFloat(rowsNumber - 1) * rowSpacing)
            maker.width.equalTo(CGFloat(columnsNumber + 1) * EqualizerComponent.defaultWidth + CGFloat(columnsNumber + 1) * columnSpacing)
        }
    }
    
    func runTimer() {
        equalizerView.runTimers()
    }
}
