//
//  UITableView+Dequeue.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func register<T: UITableViewCell>(_ cell: T.Type) where T: CellIdentifiable {
        self.register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }

    func dequeueCell<T: UITableViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T where T: CellIdentifiable {
        guard let cell = dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unknown cell! Did you forget to register it?")
        }

        return cell
    }

    private func configure(cell: UITableViewCell, from viewModel: ItemViewModel) {
        guard let cell = cell as? CellConfigurable else {
            fatalError("Cell does not implement CellConfigurable protocol! Did you forget to add it?")
        }

        cell.configure(viewModel)
    }
}
