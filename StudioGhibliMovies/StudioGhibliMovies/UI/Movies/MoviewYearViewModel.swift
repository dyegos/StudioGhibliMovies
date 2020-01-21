//
//  MoviewYearViewModel.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MovieYearViewModel: PagerCellViewModelProtocol {
    static var associatedCellReuseIdentifier: String = PagerTabCollectionViewCell.reuseIdentifier

    var title: String
    var isHighlighted = BehaviorRelay<Bool>(value: false)

    init(model: PagerDataSourceModel) {
        guard let model = model as? MovieModel,
            let date = model.movies.first?.releaseDate else { fatalError("model does not conform to PagerDataSourceModel") }

        self.title = "Released in \(date)"
    }
}
