//
//  GhibliNetwork.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift

struct GhibliNetwork: Networking {

    private let session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.default
        configuration.urlCache = URLCache(memoryCapacity: 4 * 1024 * 1024, diskCapacity: 20 * 1024 * 1024, diskPath: nil)

        return URLSession(configuration: configuration)
    }()

    var movies: Single<[Movie]> {
        self.execute(Endpoint.movies, type: [Movie].self, session: session)
    }

    func people(withUUIDs uuids: [String]) -> Single<[Person]> {
        self.execute(Endpoint.people(uuids: uuids), type: [Person].self, session: session)
    }

    func species(withUUIDs uuids: [String]) -> Single<[Specie]> {
        self.execute(Endpoint.species(uuids: uuids), type: [Specie].self, session: session)
    }
}
