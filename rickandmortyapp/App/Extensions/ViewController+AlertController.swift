//
//  ViewController+AlertController.swift
//  rickandmortyapp
//
//  Created by Manuel Colmenero Navaroo on 28/03/2021.
//

import UIKit

extension UIViewController {
    // MARK: - Create components
    func showAlert(with text: String) {
        // create the alert
        let alert = createAlertController(with: text)

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Create UIAlertController
    fileprivate func createAlertController(with text: String) -> UIAlertController {
        let alert = UIAlertController(title: NSLocalizedString("alert_title", comment: ""),
                                      message: text,
                                 preferredStyle: .alert)
        
        // add the actions (buttons)
        let confirmAction = UIAlertAction(title: NSLocalizedString("accept", comment: ""), style: .default, handler: nil)
        
        alert.addAction(confirmAction)
        
        return alert
    }
}
