//
//  MoviePersonTableViewCell.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 21/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class MovieDetailTableViewCell: UITableViewCell, CellIdentifiable, CellConfigurable {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()
        label.font = UIFont.boldSystemFont(ofSize: 14)

        return label
    }()

    private let genderLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()
        label.font = UIFont.italicSystemFont(ofSize: 12)

        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    func configure(_ model: ItemViewModel) {
        guard let model = model as? MovieCharactersCellViewModel else {
            return
        }

        if model.classification != nil {
            self.nameLabel.text = model.name
            self.genderLabel.text = model.classification
            self.ageLabel.text = model.gender
        } else {
            self.nameLabel.text = model.name
            self.genderLabel.text = model.gender
            self.ageLabel.text = model.age
        }
    }

    private func configureUI() {
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.genderLabel)
        self.contentView.addSubview(self.ageLabel)

        self.nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leadingTrailingEqualToSuperview(offset: 16)
        }

        self.genderLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leadingTrailingEqualToSuperview(offset: 16)
        }

        self.ageLabel.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(6)
            $0.leadingTrailingEqualToSuperview(offset: 16)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}
