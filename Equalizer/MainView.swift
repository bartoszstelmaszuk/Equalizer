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
    private let equalizerView: EqualizerView

    init() {
        equalizerView = EqualizerView(rowSpacing: rowSpacing, columnSpacing: columnSpacing)
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
            maker.height.equalTo(8 * EqualizerComponent.defaultHeight + 7 * rowSpacing)
            maker.width.equalTo(8 * EqualizerComponent.defaultWidth + 7 * columnSpacing)
        }
    }
    
    func runTimer() {
        equalizerView.runTimers()
    }
}
