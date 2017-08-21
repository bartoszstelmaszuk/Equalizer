//
// Created by Bartosz Stelmaszuk on 19/08/2017.
// Copyright (c) 2017 Bartosz Stelmaszuk. All rights reserved.
//

import Foundation
import UIKit

enum EqualizerComponentState {
    case on, off
}

final class EqualizerComponent: UIView {
    
    static let defaultHeight: CGFloat = 4
    static let defaultWidth: CGFloat = 15

    var state: EqualizerComponentState = .off {
        didSet {
            switch state {
                case .on: backgroundColor = .white
                case .off: backgroundColor = .lightGray
            }
        }
    }


    init() {
        super.init(frame: .zero)
        configureSelf()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureSelf() {
        layer.cornerRadius = EqualizerComponent.defaultHeight / 4
        snp.makeConstraints({ (maker) in
            maker.height.equalTo(EqualizerComponent.defaultHeight)
            maker.width.equalTo(EqualizerComponent.defaultWidth)
        })
    }
}
