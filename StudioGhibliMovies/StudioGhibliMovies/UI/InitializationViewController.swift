//
//  InitializationViewController.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class InitializationViewController: UIViewController {

    private let network = GhibliNetwork()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        network
            .movies
            .subscribe(onSuccess: { [weak self] movies in
                guard let strongSelf = self else { return }

                let moviesVC = MoviesViewController(network: strongSelf.network)
                self?.present(moviesVC, animated: true, completion: nil)
                }, onError: { [weak self] error in
                    guard let strongSelf = self else { return }

                    UIAlertController.alertError(error.localizedDescription, onViewController: strongSelf)
            }) .disposed(by: self.disposeBag)
    }
}
