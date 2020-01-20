//
//  InitializationViewController.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class InitializationViewController: RxViewController {

    private let network = GhibliNetwork()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        network
            .movies
            .subscribe(onSuccess: { [weak self] movies in
                self?.presentPager(movies: movies)
            }, onError: { [weak self] error in
                guard let strongSelf = self else { return }

                UIAlertController.alertError(error.localizedDescription, onViewController: strongSelf)
            }).disposed(by: self.disposeBag)
    }

    private func presentPager(movies: [Movie]) {
        let models: [MovieModel] = movies.map { MovieModel(movie: $0) }
        let viewModel = PagerNavigationControllerViewModel(models: models,
                                                           pagerViewModelType: MovieYearViewModel.self,
                                                           currentItemIndex: models.count - 1,
                                                           originalItemIndex: models.count - 1)

        let pagerViewModel = PagerContentViewControllerViewModel(contentType: MoviesViewController.self)
        let pagesContent = PagerContentViewController(viewModel: pagerViewModel)

        let navigation = PagerNavigationController(viewController: pagesContent, viewModel: viewModel)

        self.present(navigation, animated: true, completion: nil)
    }
}
