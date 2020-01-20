//
//  Thread+Safe.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation

extension Thread {
    class func dispatchToMainQueueIfNeeded(execute: @escaping () -> Void) {
        guard Thread.isMainThread else {
            DispatchQueue.main.async { execute() }
            return
        }

        execute()
    }
}
