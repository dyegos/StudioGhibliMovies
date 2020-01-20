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
    let producer: String
    let director: String
    let score: String

    init(title: String,
         description: String,
         producer: String,
         director: String,
         score: String) {

        self.title = title
        self.description = description
        self.producer = String(format: NSLocalizedString("produced_by", comment: ""), producer)
        self.director = String(format: NSLocalizedString("directed_by", comment: ""), director)
        self.score = String(format: NSLocalizedString("scored_as", comment: ""), score)
    }
}
