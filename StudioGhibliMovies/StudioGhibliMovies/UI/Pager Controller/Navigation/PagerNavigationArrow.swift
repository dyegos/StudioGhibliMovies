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

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_up")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let leftView = UIView()
    private let rightView = UIView()

    init() {
        super.init(frame: .zero)
        self.configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        self.addSubview(leftView)
        self.addSubview(arrowImageView)
        self.addSubview(rightView)

        leftView.backgroundColor = .myBlack
        rightView.backgroundColor = .myBlack
        arrowImageView.tintColor = .myBlack

        let lineHeight = 1 / UIScreen.main.scale
        leftView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(arrowImageView.snp.leading)
            $0.height.equalTo(lineHeight)
            $0.bottom.equalTo(arrowImageView)
        }

        arrowImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(12)
            $0.height.equalTo(6)
            $0.bottom.equalToSuperview()
        }

        rightView.snp.makeConstraints {
            $0.leading.equalTo(arrowImageView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(lineHeight)
            $0.bottom.equalTo(arrowImageView)
        }
    }
}
