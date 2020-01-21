//
//  PagerNavigationContainerProtocol.swift
//  Pager
//
//  Created by dyego de jesus silva on 14/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit

protocol PagerDataSourceModel {}

protocol PagerNavigationContainerProtocol {
    var pagerNavigation: PagerNavigationController { get }
}

extension PagerNavigationContainerProtocol where Self: UIViewController {

    var pagerNavigation: PagerNavigationController {
        // swiftlint:disable:next force_cast
        self.navigationController as! PagerNavigationController
    }
}

protocol ContentIndexable {
    func setIndex(_ index: Int)
}
