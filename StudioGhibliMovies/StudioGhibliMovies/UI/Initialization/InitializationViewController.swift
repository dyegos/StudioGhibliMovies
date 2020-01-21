//
//  InitializationViewController.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class InitializationViewController: UIViewController {

    private let network = GhibliNetwork()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .safeSystemBackground

        self.requestMovies()
    }

    private func requestMovies() {
        self.network
            .movies
            .subscribe(onSuccess: { [weak self] movies in
                self?.presentPager(movies: movies)
                }, onError: { [weak self] error in
                    guard let strongSelf = self else { return }

                    UIAlertController.alertError(error.localizedDescription,
                                                 onViewController: strongSelf,
                                                 handler: { [weak strongSelf] _ in
                                                    strongSelf?.requestMovies()
                                                 })
            }).disposed(by: self.disposeBag)
    }

    private func presentPager(movies: [Movie]) {

        let models = Dictionary(grouping: movies) { $0.releaseDate }
            .sorted { $0.value.first!.releaseDate < $1.value.first!.releaseDate  }
            .map { MovieModel(movies: $0.value) }

        let viewModel = PagerNavigationControllerViewModel(models: models,
                                                           pagerViewModelType: MovieYearViewModel.self,
                                                           currentItemIndex: models.count - 1,
                                                           originalItemIndex: models.count - 1)

        let pagerViewModel = PagerContentViewControllerViewModel(contentType: MoviesViewController.self)
        let pagesContent = PagerContentViewController(viewModel: pagerViewModel)

        let navigation = PagerNavigationController(viewController: pagesContent, viewModel: viewModel)
        navigation.modalPresentationStyle = .fullScreen

        self.present(navigation, animated: true, completion: nil)
    }
}
