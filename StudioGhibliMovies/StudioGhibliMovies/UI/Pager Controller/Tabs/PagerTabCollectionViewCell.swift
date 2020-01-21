//
//  PagerTabCollectionViewCell.swift
//  Pager
//
//  Created by dyego de jesus silva on 07/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class PagerTabCollectionViewCell: RxCollectionViewCell, CellIdentifiable, CellConfigurable {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.enableScaleToFit()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    func configure(_ model: ItemViewModel) {
        guard let viewModel = model as? PagerCellViewModelProtocol else {
            return
        }

        self.titleLabel.text = viewModel.title

        viewModel.isHighlighted
            .map({ $0 ? .myBlack : .gray })
            .subscribe(onNext: { [weak self] color in
                UIView.animate(withDuration: 0.2) {
                    self?.titleLabel.textColor = color
                }
            }).disposed(by: self.disposeBag)
    }

    private func configureUI() {
        self.contentView.addSubview(self.titleLabel)

        self.titleLabel.snp.makeConstraints {
            $0.leadingTrailingEqualToSuperview(offset: 4)
            $0.top.bottom.equalToSuperview()
        }
    }
}
