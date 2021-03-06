//
//  PagerContentViewController.swift
//  Pager
//
//  Created by dyego de jesus silva on 07/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import UIKit

struct PagerContentViewControllerViewModel {
    let contentType: UIViewController.Type
    let isBackButtonHidden = BehaviorRelay<Bool>(value: true)
}

final class PagerContentViewController: UIViewController, PagerNavigationContainerProtocol {

    // MARK: - Private properties

    private let contentCollectionView = PagerContentCollectionView()
    private let backButton = PagerScrollBackButton()
    private let viewModel: PagerContentViewControllerViewModel
    private var backButtonTrailingConstraint: Constraint?
    private let disposeBag = DisposeBag()

    // MARK: - Initialization

    init(viewModel: PagerContentViewControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .safeSystemBackground

        self.configureUI()
        self.setupObservers()

        self.contentCollectionView.register(PagerContentCollectionViewCell.self)
        self.contentCollectionView.backgroundColor = .safeSystemBackground
        self.contentCollectionView.delegate = self
        self.contentCollectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.pagerNavigation
            .itemSelected
            .subscribe(onNext: { [weak self] index in
                self?.scrollToPage(at: index, animated: true)
            }).disposed(by: disposeBag)

        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.contentCollectionView.reloadData()
            strongSelf.scrollToPage(at: strongSelf.pagerNavigation.currentItemIndex.value)
            strongSelf.updateBackButton(strongSelf.contentCollectionView)
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.contentCollectionView.collectionViewLayout.invalidateLayout()
    }

    // MARK: - Private Methods

    private func configureUI() {
        self.view.addSubview(self.contentCollectionView)
        self.view.addSubview(self.backButton)

        self.contentCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(PagerTabBarDimensionsProvider.height)
            $0.leadingTrailingEqualToSuperview(offset: 0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }

        self.backButton.snp.makeConstraints {
            $0.top.equalTo(contentCollectionView.snp.top)
            self.backButtonTrailingConstraint = $0.trailing.equalToSuperview().offset(20).constraint
            $0.height.width.equalTo(20)
        }
    }

    private func setupObservers() {
        self.viewModel
            .isBackButtonHidden
            .do(onNext: { [weak self] isHidden in
                self?.backButtonTrailingConstraint?.update(offset: isHidden ? 42 : -10)
                UIView.animate(withDuration: 0.3) {
                    self?.backButton.alpha = isHidden ? 0 : 1
                    self?.view.layoutIfNeeded()
                }
            })
            .map({ !$0 })
            .bind(to: self.backButton.rx.isEnabled)
            .disposed(by: disposeBag)

        self.backButton
            .tapEvent
            .subscribe(onNext: { [weak self] _ in
                self?.goBack()
            }).disposed(by: disposeBag)
    }

    @objc
    private func goBack() {
        self.viewModel.isBackButtonHidden.accept(true)
        self.pagerNavigation.currentItemIndex.accept(self.pagerNavigation.originalItemIndex)
        self.scrollToPage(at: self.pagerNavigation.originalItemIndex, animated: true)
    }

    private func scrollToPage(at index: Int, animated: Bool = false) {
        let pageOffsetX = CGFloat(index) * contentCollectionView.frame.width
        contentCollectionView.setContentOffset(CGPoint(x: pageOffsetX, y: 0), animated: animated)
    }

    private func updateBackButton(_ scrollView: UIScrollView) {
        guard self.pagerNavigation.dataSource.value.count >= 4 else { return }

        let offset = CGFloat(self.pagerNavigation.dataSource.value.count - 3) * scrollView.frame.width
        self.viewModel.isBackButtonHidden.accept(offset <= scrollView.contentOffset.x)
    }
}

extension PagerContentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pagerNavigation.dataSource.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueCell(PagerContentCollectionViewCell.self, indexPath: indexPath)
    }
}

extension PagerContentViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? PagerContentCollectionViewCell else {
            return
        }

        PagerContentCellBinder.bindContent(toCell: cell, fromType: self.viewModel.contentType, owner: self)
        cell.loadContent(at: indexPath.item)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percentageOfScroll = scrollView.contentOffset.x / scrollView.frame.width
        let offsetOfTopScrollX = PagerTabBarDimensionsProvider.width * percentageOfScroll

        if offsetOfTopScrollX == 0 { return }

        self.pagerNavigation.tabCollectionView.setContentOffset(CGPoint(x: offsetOfTopScrollX, y: 0), animated: false)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pagerNavigation.currentItemIndex.accept(Int(round(scrollView.contentOffset.x / scrollView.frame.width)))

        self.updateBackButton(scrollView)
    }
}
