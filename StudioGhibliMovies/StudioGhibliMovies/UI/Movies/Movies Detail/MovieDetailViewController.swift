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

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()
        label.font = UIFont.boldSystemFont(ofSize: 14)

        return label
    }()

    private let genderLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()
        label.font = UIFont.italicSystemFont(ofSize: 12)

        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.enableScaleToFit()
        label.font = UIFont.systemFont(ofSize: 12)

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        configureUI()
    }

    func configure(_ model: ItemViewModel) {
        guard let model = model as? MoviePersonCellViewModel else {
            return
        }

        self.nameLabel.text = model.name
        self.genderLabel.text = model.gender
        self.ageLabel.text = model.age
    }

    private func configureUI() {
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.genderLabel)
        self.contentView.addSubview(self.ageLabel)

        self.nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leadingTrailingEqualToSuperview(offset: 16)
        }

        self.genderLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leadingTrailingEqualToSuperview(offset: 16)
        }

        self.ageLabel.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(6)
            $0.leadingTrailingEqualToSuperview(offset: 16)
            $0.bottom.equalToSuperview().offset(-10)
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onDismiss))

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
            .bind(dataSource: self.viewModel.models, cellType: MoviePersonTableViewCell.self)
            .disposed(by: disposeBag)

        if self.viewModel.movie.people.isEmpty == false {
            self.network
                .people(withUUIDs: self.viewModel.movie.people)
                .map({ $0.map { MoviePersonCellViewModel(name: $0.name, gender: $0.gender, age: $0.age) } })
                .subscribe(onSuccess: { [weak self] people in
                    guard let strongSelf = self else { return }
                    strongSelf.viewModel.models.accept(strongSelf.viewModel.models.value + people)
                }, onError: { [weak self] error in
                        guard let strongSelf = self else { return }
                        UIAlertController.alertError(error.localizedDescription, onViewController: strongSelf)
                }).disposed(by: disposeBag)
        }

        if self.viewModel.movie.species.isEmpty == false {
            self.network
                .species(withUUIDs: self.viewModel.movie.species)
                .map({ $0.map { MoviePersonCellViewModel(name: $0.name, gender: $0.classification, age: $0.classification) } })
                .subscribe(onSuccess: { [weak self] people in
                    guard let strongSelf = self else { return }
                    strongSelf.viewModel.models.accept(strongSelf.viewModel.models.value + people)
                }, onError: { [weak self] error in
                        guard let strongSelf = self else { return }
                        UIAlertController.alertError(error.localizedDescription, onViewController: strongSelf)
                }).disposed(by: disposeBag)
        }
    }

    @objc private func onDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
