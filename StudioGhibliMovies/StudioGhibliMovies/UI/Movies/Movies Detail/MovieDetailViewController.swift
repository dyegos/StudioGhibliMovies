//
//  MovieDetailViewController.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 21/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class MoviePersonTableViewCell: UITableViewCell, CellIdentifiable, CellConfigurable {

    func configure(_ model: ItemViewModel) {
        guard let model = model as? MoviePersonCellViewModel else {
            return
        }
    }
}

struct MoviePersonCellViewModel: ItemViewModel {
    static var associatedCellReuseIdentifier = MoviePersonTableViewCell.reuseIdentifier

    let name: String
    let gender: String
    let age: String
}

struct MovieDetailControllerViewModel {
    let models = BehaviorRelay<[MoviePersonCellViewModel]>(value: [])
    let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }
}

final class MovieDetailViewController: UIViewController {

    private let viewModel: MovieDetailControllerViewModel
    private let network: GhibliNetwork
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let disposeBag = DisposeBag()

    init(viewModel: MovieDetailControllerViewModel,
         network: GhibliNetwork = GhibliNetwork()) {
        self.viewModel = viewModel
        self.network = network
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(self.tableView)
        self.tableView.register(MoviePersonTableViewCell.self)
        self.tableView.backgroundColor = .white
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsSelection = false

        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.tableView
            .rx
            .bind(dataSource: viewModel.models, cellType: MoviePersonTableViewCell.self)
            .disposed(by: disposeBag)

        self.network
            .people(withUUIDs: self.viewModel.movie.people)
            .map({ $0.map({ MoviePersonCellViewModel(name: $0.name, gender: $0.gender, age: $0.age)  })  })
            .subscribe(onSuccess: { [weak self] people in
                self?.viewModel.models.accept(people)
            }, onError: { [weak self] error in
                guard let strongSelf = self else { return }
                UIAlertController.alertError(error.localizedDescription, onViewController: strongSelf)
            }).disposed(by: disposeBag)
    }
}
