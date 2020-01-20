//
//  Extensions.swift
//  Pager
//
//  Created by dyego de jesus silva on 16/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }

    func addSubviews(_ views: [UIView]) {
        views.forEach(addSubview)
    }
}
