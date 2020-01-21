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

        self.title = self.viewModel.movie.title
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onDismiss))

        self.setupUI()
        self.setupObservers()
    }

    private func setupUI() {

        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = self.viewModel.movie.description

        self.view.addSubview(label)
        self.view.addSubview(self.tableView)
        self.tableView.register(MovieDetailTableViewCell.self)
        self.tableView.backgroundColor = .white
        self.tableView.tableFooterView = UIView()
        self.tableView.allowsSelection = false

        label.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leadingTrailingEqualToSuperview(offset: 16)
            $0.height.greaterThanOrEqualTo(10)
        }

        self.tableView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(6)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func setupObservers() {
        self.tableView
            .rx
            .bind(dataSource: self.viewModel.models, cellType: MovieDetailTableViewCell.self)
            .disposed(by: disposeBag)

        if self.viewModel.movie.people.isEmpty == false {
            self.network
                .people(withUUIDs: self.viewModel.movie.people)
                .map({ $0.map { MovieCharactersCellViewModel(name: $0.name, gender: $0.gender, age: $0.age) } })
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
                .map({ $0.map { MovieCharactersCellViewModel(name: $0.name, classification: $0.classification) } })
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
