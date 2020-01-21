//
//  ContentFillCollectionFlowLayout.swift
//  Pager
//
//  Created by dyego de jesus silva on 07/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit

final class ContentFillCollectionFlowLayout: UICollectionViewFlowLayout {

    private var layoutAttributeCache = [UICollectionViewLayoutAttributes]()

    private var numberOfItems: Int {
        guard let collectionView = collectionView else {
            return 0
        }

        return collectionView.numberOfItems(inSection: 0)
    }

    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            return UIScreen.main.bounds.size
        }

        let width = CGFloat(self.numberOfItems) * collectionView.frame.size.width
        let height = collectionView.frame.size.height

        return CGSize(width: width, height: height)
    }

    override init() {
        super.init()

        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }

        self.itemSize = collectionViewContentSize

        if !layoutAttributeCache.isEmpty {
            layoutAttributeCache.removeAll()
        }

        let section = 0

        (0..<self.numberOfItems).forEach { index in
            let indexPath = IndexPath(row: index, section: section)

            let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            /* set new frame to layoutAttributes */
            layoutAttribute.frame = CGRect(x: CGFloat(index) * collectionView.frame.size.width,
                                           y: 0,
                                           width: collectionView.frame.size.width,
                                           height: collectionView.frame.size.height)
            /* append all attributes in cache */
            layoutAttributeCache.append(layoutAttribute)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributeCache.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributeCache.first { $0.indexPath == indexPath }
    }
}
