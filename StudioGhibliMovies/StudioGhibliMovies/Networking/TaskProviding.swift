//
//  TaskProviding.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation

enum Method: String {
    case get = "GET"
}

protocol TaskProviding {
    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
}
