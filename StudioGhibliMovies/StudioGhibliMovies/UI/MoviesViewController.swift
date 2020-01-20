//
//  MoviesViewController.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit

final class MoviesViewController: RxViewController, ContentIndexable, PagerNavigationContainerProtocol {

    private let network = GhibliNetwork()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }

    func setIndex(_ index: Int) {

    }
}
