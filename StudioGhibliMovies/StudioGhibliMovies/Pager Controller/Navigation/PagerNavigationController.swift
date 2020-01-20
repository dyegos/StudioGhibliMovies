//
//  PagerNavigationController.swift
//  Pager
//
//  Created by dyego de jesus silva on 08/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class PagerNavigationController: UINavigationController {

    // MARK: - Public Methods

    var itemSelected: Observable<Int> { self.tabCollectionView.rx.itemSelected.map({ $0.item }) }
    var currentItemIndex: BehaviorRelay<Int> { self.viewModel.currentItemIndex }
    var originalItemIndex: Int { self.viewModel.originalItemIndex }
    var dataSource: BehaviorRelay<[PagerDataSourceModel]> { self.viewModel.dataSource }
    let tabCollectionView = PagerTabCollectionView()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private var viewModel: PagerNavigationControllerViewModel
    private let navigationArrow = PagerNavigationArrow()

    // MARK: - Initialization

    convenience init(tabBarController: UITabBarController, viewModel: PagerNavigationControllerViewModel) {
        self.init(viewController: tabBarController, viewModel: viewModel)
        self.setupObserver(inTabBarController: tabBarController)
    }

    init(viewController: UIViewController, viewModel: PagerNavigationControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = [viewController]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabCollectionView.register(PagerTabCollectionViewCell.self)
        self.tabCollectionView.backgroundColor = .white

        self.setupUI()
        self.setupObservers()
    }

    // MARK: - Private Methods

    private func setupObserver(inTabBarController tabBarController: UITabBarController) {
        tabBarController
            .rx
            .didSelect
            .map({ ($0 is PagerNavigationContainerProtocol) == false })
            .subscribe(onNext: { [weak self] isHidden in
                self?.tabCollectionView.isHidden = isHidden
                self?.navigationArrow.isHidden = isHidden
            }).disposed(by: disposeBag)
    }

    private func setupUI() {
        self.view.addSubviews(tabCollectionView, navigationArrow)

        tabCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.navigationBar.snp.bottom)
            $0.leadingTrailingEqualToSuperview(offset: 0)
            $0.height.equalTo(PagerTabBarDimensionsProvider.height)
        }

        navigationArrow.snp.makeConstraints {
            $0.bottom.equalTo(tabCollectionView.snp.bottom)
            $0.leadingTrailingEqualToSuperview(offset: 0)
        }
    }

    private func setupObservers() {
        self.tabCollectionView
            .rx
            .bind(dataSource: self.tabCollectionView.viewModels,
                  cellType: PagerTabCollectionViewCell.self,
                  configureCell: { viewModel, cell in
                    cell.configure(viewModel)
            }).disposed(by: disposeBag)

        self.tabCollectionView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.currentItemIndex.accept(indexPath.item)
            }).disposed(by: disposeBag)

        self.viewModel
            .dataSource
            .map({ $0.compactMap { [weak self] in self?.viewModel.pagerViewModelType.init(model: $0) } })
            .subscribe(onNext: { [weak self] viewModels in
                self?.tabCollectionView.configure(viewModels: viewModels)
            }).disposed(by: disposeBag)

        self.viewModel
            .currentItemIndex
            .subscribe(onNext: { [weak self] index in
                self?.tabCollectionView.setFocusToTab(at: index)
            }).disposed(by: disposeBag)
    }
}
