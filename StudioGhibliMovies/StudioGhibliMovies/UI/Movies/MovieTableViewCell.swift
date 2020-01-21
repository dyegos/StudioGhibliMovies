//
//  MovieTableViewCell.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit

final class MovieTableViewCell: RxTableViewCell, CellIdentifiable, CellConfigurable {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()
        label.font = UIFont.boldSystemFont(ofSize: 14)

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()

    private let directorLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()
        label.font = UIFont.italicSystemFont(ofSize: 10)

        return label
    }()

    private let producerLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()
        label.font = UIFont.italicSystemFont(ofSize: 10)

        return label
    }()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.enableScaleToFit()
        label.font = UIFont.systemFont(ofSize: 14)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configureUI()
    }

    private func configureUI() {
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.directorLabel)
        self.contentView.addSubview(self.producerLabel)
        self.contentView.addSubview(self.scoreLabel)

        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(16)
        }

        self.scoreLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel)
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(self.titleLabel)
        }

        self.descriptionLabel.snp.makeConstraints {
            $0.leadingTrailingEqualToSuperview(offset: 16)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(6)
        }

        self.directorLabel.snp.makeConstraints {
            $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(6)
            $0.leadingTrailingEqualToSuperview(offset: 16)
        }

        self.producerLabel.snp.makeConstraints {
            $0.top.equalTo(self.directorLabel.snp.bottom).offset(6)
            $0.leadingTrailingEqualToSuperview(offset: 16)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }

    func configure(_ model: ItemViewModel) {
        guard let model = model as? MovieCellViewModel else { return }

        self.titleLabel.text = model.title
        self.scoreLabel.text = model.score
        self.descriptionLabel.text = model.description
        self.directorLabel.text = model.director
        self.producerLabel.text = model.producer
    }
}
