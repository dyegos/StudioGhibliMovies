//
//  PagerContentCellBinder.swift
//  Pager
//
//  Created by dyego de jesus silva on 13/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit

final class PagerContentCellBinder {

    /// Bind a view controller to a cell
    /// - Parameters:
    ///   - cell: The cell to bind a view controller
    ///   - contentType: The class type of view controller's content
    ///   - owner: The owner of the child view controller
    static func bindContent(toCell cell: PagerContentCollectionViewCell,
                            fromType contentType: UIViewController.Type,
                            owner: UIViewController) {

        if cell.contentViewController == nil {
            let content = contentType.init()
            cell.contentViewController = content
            owner.addChild(content)
            content.didMove(toParent: owner)

            cell.contentView.addSubview(content.view)
            content.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }
}
