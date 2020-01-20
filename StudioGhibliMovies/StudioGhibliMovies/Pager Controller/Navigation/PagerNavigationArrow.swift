//
//  PagerNavigationArrow.swift
//  Pager
//
//  Created by dyego de jesus silva on 14/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit

final class PagerNavigationArrow: UIView {
    let arrowView = UIView()
    let leftView = UIView()
    let rightView = UIView()

    init() {
        super.init(frame: .zero)
        self.configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        self.addSubviews(leftView, arrowView, rightView)

        leftView.backgroundColor = .lightGray
        rightView.backgroundColor = .lightGray
        arrowView.backgroundColor = .gray

        let lineHeight = 1 / UIScreen.main.scale
        leftView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(arrowView.snp.leading)
            $0.height.equalTo(lineHeight)
            $0.bottom.equalTo(arrowView)
        }

        arrowView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(12)
            $0.height.equalTo(6)
            $0.bottom.equalToSuperview()
        }

        rightView.snp.makeConstraints {
            $0.leading.equalTo(arrowView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(lineHeight)
            $0.bottom.equalTo(arrowView)
        }
    }
}
