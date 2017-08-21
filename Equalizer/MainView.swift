//
// Created by Bartosz Stelmaszuk on 19/08/2017.
// Copyright (c) 2017 Bartosz Stelmaszuk. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class MainView: UIView {
    
    private let equalizerView = EqualizerView()

    init() {
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
            maker.height.equalToSuperview().multipliedBy(0.3)
            maker.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func runTimer() {
        equalizerView.runTimers()
    }
}
