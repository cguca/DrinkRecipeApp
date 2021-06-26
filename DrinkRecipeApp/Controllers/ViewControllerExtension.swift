//
//  ViewControllerExtension.swift
//  DrinkRecipeApp
//
//  Created by Cary Guca on 6/25/21.
//

import UIKit

extension UIViewController {
    
    func showApiErrorAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
