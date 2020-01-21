//
//  Endpoint.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation

enum Endpoint {
    case movies
    case people(uuids: [String])
}

extension Endpoint: RequestProviding, TaskProviding {
    var baseURL: URL {
        return URL(string: "https://ghibliapi.herokuapp.com/")!
    }

    var path: String {
        switch self {
        case .movies:
            return "films"
        case .people:
            return "people"
        }
    }

    var method: Method {
        return .get
    }

    var urlRequest: URLRequest {
        guard let url = self.buildURL else {
            preconditionFailure("Unable to build a valid URL")
        }

        var newURL = url
        switch self {
        case .people(let uuids):
            let items: [URLQueryItem] = uuids.map({ URLQueryItem(name: "id", value: $0) })
            var com = URLComponents(url: newURL, resolvingAgainstBaseURL: false)!
            com.queryItems = items
            newURL = com.url!
        default: break
        }

        var request = URLRequest(url: newURL)
        request.httpMethod = self.method.rawValue
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpShouldHandleCookies = false

        return request
    }

    private var buildURL: URL? { URL(string: self.path, relativeTo: self.baseURL) }
}
