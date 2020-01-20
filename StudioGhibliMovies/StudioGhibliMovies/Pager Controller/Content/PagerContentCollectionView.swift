//
//  PagerContentCollectionView.swift
//  Pager
//
//  Created by dyego de jesus silva on 07/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class PagerContentCollectionView: RxCollectionView {

    let viewModels = BehaviorRelay<[PagerContentCellViewModel]>(value: [])

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = PagerTabBarDimensionsProvider.collectionSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        super.init(frame: .zero, collectionViewLayout: layout)
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.allowsSelection = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModels: [PagerContentCellViewModel]) {
        self.viewModels.accept(viewModels)
    }
}
