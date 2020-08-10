//
//  AlertService.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-03.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class AlertService: NSObject {
    
    static func alert(controller: UIViewController, title: String, message: String, actionTitle: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default) { (action) in
            completion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        alert.addActions([okAction, cancelAction]) 
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func settingsAlert(controller: UIViewController, title: String, message: String, actionTitle: String) {
        AlertService.alert(controller: controller, title: title, message: message, actionTitle: actionTitle) {
            guard let settingsURL = URL(string:UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
    }
    
}
