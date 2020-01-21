//
//  MoviesViewController.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

final class MoviesViewController: UIViewController, ContentIndexable, PagerNavigationContainerProtocol {

    private let models = BehaviorRelay<[MovieCellViewModel]>(value: [])
    private let network = GhibliNetwork()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(self.tableView)
        self.tableView.register(MovieTableViewCell.self)
        self.tableView.backgroundColor = .white
        self.tableView.tableFooterView = UIView()

        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.tableView
            .rx
            .bind(dataSource: models, cellType: MovieTableViewCell.self)
            .disposed(by: disposeBag)

        self.tableView
            .rx
            .itemSelected
            .compactMap({ [weak self] indexPath -> Movie? in
                guard let strongSelf = self else { return nil }
                let currentIndex = strongSelf.pagerNavigation.currentItemIndex.value
                let model = strongSelf.pagerNavigation.dataSource.value[currentIndex] as? MovieModel

                return model?.movies[indexPath.row]
            })
            .subscribe(onNext: { [weak self] movie in
                self?.presentMovieDetail(with: movie)
            }).disposed(by: disposeBag)
    }

    func setIndex(_ index: Int) {
        self.pagerNavigation
            .dataSource
            .compactMap({ $0[index] as? MovieModel })
            .subscribe(onNext: { [weak self] model in
                self?.loadData(from: model)
            }).disposed(by: disposeBag)
    }

    private func presentMovieDetail(with movie: Movie) {
        let viewModel = MovieDetailControllerViewModel(movie: movie)
        let movieDetailVC = MovieDetailViewController(viewModel: viewModel)

        self.navigationController?.present(movieDetailVC, animated: true, completion: nil)
    }

    private func loadData(from model: MovieModel) {

        DispatchQueue.global(qos: .userInitiated).async {
            let movies = model.movies.map({ MovieCellViewModel(id: $0.id,
                                                               title: $0.title,
                                                               description: $0.description,
                                                               producer: $0.producer,
                                                               director: $0.director,
                                                               score: $0.score) })
            DispatchQueue.main.async { [weak self] in
                self?.models.accept(movies)
                self?.tableView.reloadData()
            }
        }
    }
}
