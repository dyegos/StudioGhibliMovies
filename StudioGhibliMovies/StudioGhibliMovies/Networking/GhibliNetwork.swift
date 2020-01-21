//
//  GhibliNetwork.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift

final class GhibliNetwork: Networking {

    private let disposeBag = DisposeBag()

    var movies: Single<[Movie]> {
        self.execute(Endpoint.movies, type: [Movie].self)
    }

    func people(withUUIDs uuids: [String]) -> Single<[Person]> {
        self.execute(Endpoint.people(uuids: uuids), type: [Person].self)
    }

    func species(withUUIDs uuids: [String]) -> Single<[Specie]> {
        self.execute(Endpoint.species(uuids: uuids), type: [Specie].self)
    }
}
