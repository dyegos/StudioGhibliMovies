//
//  UICollectionView+dataSourceBinder.swift
//  Pager
//
//  Created by dyego de jesus silva on 14/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UICollectionView {

    func bind<Cell: UICollectionViewCell, ViewModel: ItemViewModel>
        (dataSource: BehaviorRelay<[ViewModel]>,
         cellType: Cell.Type,
         configuredCell: ((_ cell: Cell) -> Void)? = nil)
        -> Disposable where Cell: CellIdentifiable & CellConfigurable {

            return dataSource
                .bind(to: self
                    .items(cellIdentifier: cellType.reuseIdentifier,
                           cellType: cellType.self)) { _, viewModel, cell in
                            cell.configure(viewModel)
                            configuredCell?(cell)
            }
    }

    func bind<Cell: UICollectionViewCell, ViewModel: ItemViewModel>
        (dataSource: Observable<[ViewModel]>,
         cellType: Cell.Type,
         configuredCell: ((_ cell: Cell) -> Void)? = nil)
        -> Disposable where Cell: CellIdentifiable & CellConfigurable {

            return dataSource
                .bind(to: self
                    .items(cellIdentifier: cellType.reuseIdentifier,
                           cellType: cellType.self)) { _, viewModel, cell in
                            cell.configure(viewModel)
                            configuredCell?(cell)
            }
    }

    func bind<Cell: UICollectionViewCell, ViewModel>
        (dataSource: BehaviorRelay<[ViewModel]>,
         cellType: Cell.Type,
         configureCell: ((_ viewModel: ViewModel, _ cell: Cell) -> Void)? = nil)
        -> Disposable where Cell: CellIdentifiable & CellConfigurable {

            return dataSource
                .bind(to: self
                    .items(cellIdentifier: cellType.reuseIdentifier,
                           cellType: cellType.self)) { _, viewModel, cell in
                            configureCell?(viewModel, cell)
            }
    }
}
