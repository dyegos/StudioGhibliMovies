//
//  Movie.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation

struct People: Decodable {
    let name: String
    let gender: String
    let age: String
}

struct Movie: Decodable {
    let id: String
    let title: String
    let description: String
    let director: String
    let producer: String
    let releaseDate: String
    let score: String
    let people: [String]
    let species: [String]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        producer = try container.decode(String.self, forKey: .producer)
        director = try container.decode(String.self, forKey: .director)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        score = try container.decode(String.self, forKey: .score)
        let people = try container.decode([String].self, forKey: .score)
        let species = try container.decode([String].self, forKey: .score)

        self.people = people.compactMap { URL(string: $0)?.pathComponents[2] }
        self.species = species.compactMap { URL(string: $0)?.pathComponents[2] }
    }

    enum CodingKeys: String, CodingKey {
        case id, title, description, director
        case producer, people, species
        case releaseDate = "release_date"
        case score = "rt_score"
    }
}
