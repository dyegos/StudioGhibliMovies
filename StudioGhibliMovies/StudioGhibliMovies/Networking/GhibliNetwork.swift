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

    func people(withUUIDs uuids: [String]) -> Single<[People]> {
        self.execute(Endpoint.people(uuids: uuids), type: [People].self)
    }
}
