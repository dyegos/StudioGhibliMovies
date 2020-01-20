//
//  SnapKit.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import SnapKit

extension ConstraintMaker {
    func leadingTrailingEqualToSuperview(offset: Int) {
        self.leading.equalToSuperview().offset(offset)
        self.trailing.equalToSuperview().offset(-offset)
    }

    func topBottomEqualToSuperview(offset: Int) {
        self.top.equalToSuperview().offset(offset)
        self.bottom.equalToSuperview().offset(-offset)
    }

    func edgesEqualToSuperview(offset: Int) {
        self.topBottomEqualToSuperview(offset: offset)
        self.leadingTrailingEqualToSuperview(offset: offset)
    }
}
