//
//  MovieTableViewCell.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit

final class MovieTableViewCell: RxTableViewCell, CellIdentifiable, CellConfigurable {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()

        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()

        return label
    }()

    private let directorLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()

        return label
    }()

    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()

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

    }

    func configure(_ model: ItemViewModel) {
        guard let model = model as? MovieCellViewModel else { return }
    }
}
