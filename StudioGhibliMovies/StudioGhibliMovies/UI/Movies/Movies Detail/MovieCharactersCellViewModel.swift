//
//  File.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 21/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation

struct MovieCharactersCellViewModel: ItemViewModel {
    static var associatedCellReuseIdentifier = MovieDetailTableViewCell.reuseIdentifier

    let name: String
    let gender: String
    let age: String?
    let classification: String?

    init(name: String, gender: String, age: String) {
        self.name = String(format: "Specie: %@", name)
        self.gender = String(format: "Gender: %@", gender)
        self.age = String(format: "Age: %@", age)
        self.classification = nil
    }

    init(name: String, classification: String) {
        self.name = String(format: "Specie: %@", name)
        self.gender = "Unknown"
        self.age = nil
        self.classification = String(format: "Classification: %@", classification)
    }
}
