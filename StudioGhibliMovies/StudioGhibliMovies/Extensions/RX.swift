//
//  RX.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class RxViewController: UIViewController {
    let disposeBag = DisposeBag()
}

class RxTableViewController: UITableViewController {
    let disposeBag = DisposeBag()
}

class RxTableViewCell: UITableViewCell {
    lazy var disposeBag: DisposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()

        self.disposeBag = DisposeBag()
        self.forwardToPrepareForReuse()
    }

    func forwardToPrepareForReuse() { }
}

class RxCollectionViewCell: UICollectionViewCell {
    lazy var disposeBag: DisposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()

        self.disposeBag = DisposeBag()
    }
}

class RxCollectionView: UICollectionView {
    lazy var disposeBag: DisposeBag = DisposeBag()
}
