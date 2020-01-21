//
//  PagerTabCollectionView.swift
//  Pager
//
//  Created by dyego de jesus silva on 07/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct PagerTabBarDimensionsProvider {
    static var size: CGSize { CGSize(width: UIScreen.main.bounds.width / 3.0, height: 26.0) }
    static var width: CGFloat { Self.size.width }
    static var height: CGFloat { Self.size.height }
    static var collectionSize: CGSize { CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 26.0) }
}

final class PagerTabCollectionView: UICollectionView {

    let viewModels = BehaviorRelay<[PagerCellViewModelProtocol]>(value: [])
    private let disposeBag = DisposeBag()

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = PagerTabBarDimensionsProvider.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: layout.itemSize.width, bottom: 0, right: layout.itemSize.height)

        super.init(frame: .zero, collectionViewLayout: layout)
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.isScrollEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModels: [PagerCellViewModelProtocol]) {
        self.viewModels.accept(viewModels)
    }

    /// Change the tab focus from a given index
    /// This method will reset all values from `isHighlighted` inside the view models to false
    /// and than enable only the given index.
    /// - Parameter index: A valid index where a tab should be highlighted
    func setFocusToTab(at index: Int) {
        let range = 0..<self.viewModels.value.count
        guard range.contains(index) else { return } // in case an invalid index is sent, just ignore it

        self.viewModels.value.forEach({ $0.isHighlighted.accept(false) })
        self.viewModels.value[index].isHighlighted.accept(true)
    }
}
