//
//  PagerCellViewModelProtocol.swift
//  Pager
//
//  Created by dyego de jesus silva on 16/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol PagerCellViewModelProtocol: ItemViewModel {
    var title: String { get }
    var isHighlighted: BehaviorRelay<Bool> { get }

    init(model: PagerDataSourceModel)
}
