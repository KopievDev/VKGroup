//
//  UIAlertController.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

extension UIAlertController {
    class func show(title: String? = nil,
                    message: String? = nil,
                    buttonTitles: [String]?,
                    style:UIAlertController.Style = .alert,
                    highlightedButtonIndex: Int? = nil,
                    completion: ((Int)->Void)? = nil) {
        guard let vc = UIApplication.topViewController() else { return }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {allButtons.append("OK")}
        
        allButtons.indices.forEach { index in
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                completion?(index)
            })
            alertController.addAction(action)
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                alertController.preferredAction = action
            }
        }
        
        vc.present(alertController, animated: true, completion: nil)
    }
}
