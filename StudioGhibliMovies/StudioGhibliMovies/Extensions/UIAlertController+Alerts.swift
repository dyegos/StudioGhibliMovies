//
//  UIAlertController+Alerts.swift
//  StudioGhibliMovies
//
//  Created by dyego de jesus silva on 20/01/2020.
//  Copyright © 2020 Dyego Silva. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func alertError(_ message: String, onViewController viewController: UIViewController,
                           handler: ((UIAlertAction) -> Void)? = nil) {
        let title = NSLocalizedString("error_title", comment: "")

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: handler))
        viewController.present(alert, animated: true, completion: nil)
    }
}
