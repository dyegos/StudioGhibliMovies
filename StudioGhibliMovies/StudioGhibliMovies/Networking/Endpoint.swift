//
//  Endpoint.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation

enum Endpoint {
    case movies
}

extension Endpoint: RequestProviding, TaskProviding {
    var baseURL: URL {
        return URL(string: "https://ghibliapi.herokuapp.com")!
    }

    var path: String {
        switch self {
        case .movies:
            return "/films"
        }
    }

    var method: Method {
        switch self {
        default:
            return .get
        }
    }

    var urlRequest: URLRequest {
        switch self {
        case .movies:
            guard let url = self.buildURL else {
                preconditionFailure("Unable to build a valid URL")
            }

            var request = URLRequest(url: url)
            request.httpMethod = self.method.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            return request
        }
    }

    private var buildURL: URL? { URL(string: self.path, relativeTo: self.baseURL) }
}
