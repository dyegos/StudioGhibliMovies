//
//  UICollectionView+Dequeue.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func register<T: UICollectionViewCell>(_ cell: T.Type) where T: CellIdentifiable {
        register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }

    func dequeueCell<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T where T: CellIdentifiable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unknown cell! Did you forget to register it?")
        }

        return cell
    }

    private func configure(cell: UICollectionViewCell, from viewModel: ItemViewModel) {
        guard let cell = cell as? CellConfigurable else {
            fatalError("Cell does not implement CellConfigurable protocol! Did you forget to add it?")
        }

        cell.configure(viewModel)
    }
}
