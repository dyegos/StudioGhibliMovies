//
//  Person.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 21/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation

struct Person: Decodable {
    let name: String
    let gender: String
    let age: String
}

struct Specie: Decodable {
    let name: String
    let classification: String
}
