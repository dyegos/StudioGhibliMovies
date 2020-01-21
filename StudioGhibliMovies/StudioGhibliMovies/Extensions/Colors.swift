//
//  Colors.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 21/01/2020.
//  Copyright © 2020 Some. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var safeSystemBackground: UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }

    static var myBlack = UIColor(named: "black")!
}
