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

    init() {
        super.init(frame: .zero, collectionViewLayout: ContentFillCollectionFlowLayout())
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.allowsSelection = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
