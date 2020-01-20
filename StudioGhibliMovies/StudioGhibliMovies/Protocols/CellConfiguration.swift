//
//  Protocols.swift
//  Pager
//
//  Created by dyego de jesus silva on 16/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit

protocol CellModelIdentifiable {
    static var associatedCellReuseIdentifier: String { get }
}

protocol ItemViewModel: CellModelIdentifiable {}

protocol CellConfigurable {
    /// Configure any cell that conforms to CellConfigurable with a given model
    ///
    /// - Parameter model: Any view model that conforms to ItemViewModel created a swift version.
    func configure(_ model: ItemViewModel)
}

protocol CellIdentifiable {
    /// Return the reusable identifier for a cell created a swift version.
    static var reuseIdentifier: String { get }
}

extension CellIdentifiable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension CellIdentifiable where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
