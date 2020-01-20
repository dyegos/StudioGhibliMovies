//
//  File.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation

struct MovieCellViewModel: ItemViewModel, CellModelIdentifiable {
    static var associatedCellReuseIdentifier = MovieTableViewCell.reuseIdentifier

    let title: String
    let description: String
    let director: String
    let score: String
}
