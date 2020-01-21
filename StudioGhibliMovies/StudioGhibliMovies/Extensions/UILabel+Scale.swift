//
//  UILabel+Scale.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func enableScaleToFit(scaleFactor: CGFloat = 0.25) {
        self.minimumScaleFactor = scaleFactor
        self.adjustsFontSizeToFitWidth = true
    }
}
