//
//  UtilFunctions.swift
//  ParentPay Technical Test
//
//  Created by student on 2024-05-04.
//

import Foundation
import UIKit

class UtilFunctions {
    
    static func showAlertMessage(viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true)
    }
    
}
