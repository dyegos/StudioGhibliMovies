//
//  Network.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift

protocol Networking {
    func execute<T: Decodable>(_ requestProvider: RequestProviding, type: T.Type) -> Single<T>
}

extension Networking {

    func execute<T: Decodable>(_ requestProvider: RequestProviding, type: T.Type) -> Single<T> {
        Single<T>.create(subscribe: { single in
            let urlRequest = requestProvider.urlRequest

            let session = URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }

                guard let data = data else {
                    let error = NSError(domain: "Data is null", code: 0, userInfo: [:])
                    single(.error(error))
                    return
                }

                DispatchQueue.global(qos: .userInteractive).async {
                    guard let decoded = try? JSONDecoder().decode(type, from: data) else {
                        DispatchQueue.main.async {
                            let error = NSError(domain: "Unable to parse data", code: 0, userInfo: ["data": data.description])
                            single(.error(error))
                        }
                        return
                    }

                    DispatchQueue.main.async {
                        single(.success(decoded))
                    }
                }
            })

            session.resume()

            return Disposables.create { session.cancel() }
        })
    }
}
