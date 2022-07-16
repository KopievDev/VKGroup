//
//  UIRefreshControl.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 16.07.2022.
//

import UIKit

extension UIRefreshControl {
    
    convenience init(text: String = "", target: Any?, action: Selector ) {
        self.init()
        attributedTitle = NSAttributedString(string: text)
        addTarget(target, action: action, for: .valueChanged)
    }
}
