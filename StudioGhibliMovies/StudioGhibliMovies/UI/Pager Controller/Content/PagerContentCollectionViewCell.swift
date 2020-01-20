//
//  PagerContentCollectionViewCell.swift
//  Pager
//
//  Created by dyego de jesus silva on 07/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

final class PagerContentCollectionViewCell: RxCollectionViewCell, CellIdentifiable, CellConfigurable {

    var contentViewController: UIViewController?

    /// Trigger the content loading from a given index.
    /// The index is a representation of the current data source.
    /// It can be used to retrieve the main data source data to load the content
    /// - Parameter index: A valid index to load the content
    func loadContent(at index: Int) {
        guard let viewController = self.contentViewController as? ContentIndexable else {
            preconditionFailure("contentType does not conform to ContentIndexable")
        }

        viewController.setIndex(index)
    }

    func configure(_ model: ItemViewModel) {}
}
