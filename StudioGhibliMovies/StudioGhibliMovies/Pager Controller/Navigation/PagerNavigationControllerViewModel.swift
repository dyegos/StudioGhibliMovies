//
//  PagerNavigationControllerViewModel.swift
//  Pager
//
//  Created by dyego de jesus silva on 08/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct PagerNavigationControllerViewModel {
    let dataSource: BehaviorRelay<[PagerDataSourceModel]>
    let pagerViewModelType: PagerCellViewModelProtocol.Type
    let currentItemIndex: BehaviorRelay<Int>
    let originalItemIndex: Int

    /// Create a view model for PagerNavigationController that will be use to handle all content data.
    /// - Parameters:
    ///   - models: The pager main data source that conforms to PagerDataSourceModel
    ///   - pagerViewModelType: The data source's type that will be used to create view models for tabs
    ///   - currentItemIndex: The current selected index, this can be any valid index from models
    ///   - originalItemIndex: The index where the page should scroll back when a scrollBack button is touched.
    init(models: [PagerDataSourceModel],
         pagerViewModelType: PagerCellViewModelProtocol.Type,
         currentItemIndex: Int,
         originalItemIndex: Int) {
        self.dataSource = BehaviorRelay<[PagerDataSourceModel]>(value: models)
        self.pagerViewModelType = pagerViewModelType
        self.currentItemIndex = BehaviorRelay<Int>(value: currentItemIndex)
        self.originalItemIndex = originalItemIndex
    }
}
