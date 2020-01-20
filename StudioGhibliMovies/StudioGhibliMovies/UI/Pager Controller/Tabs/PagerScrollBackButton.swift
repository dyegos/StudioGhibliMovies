//
//  PagerScrollBackButton.swift
//  Pager
//
//  Created by dyego de jesus silva on 14/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PagerScrollBackButton: UIButton {

    var tapEvent: ControlEvent<Void> { self.rx.tap }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.setImage(UIImage(named: "back_icon"), for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
