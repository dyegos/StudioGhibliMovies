//
//  MovieDetailControllerViewModel.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 21/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import RxCocoa

struct MovieDetailControllerViewModel {

    let models = BehaviorRelay<[MovieCharactersCellViewModel]>(value: [])
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
}
