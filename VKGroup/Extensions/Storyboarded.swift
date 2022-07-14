//
//  Storyboarded.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> UIViewController?
    static func instantiateWithNav() -> UIViewController?
    static var storyboardName: String {get}
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        return storyboard.instantiateInitialViewController() as? Self
    }
    
    static func instantiateWithNav() -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        let navVc =  storyboard.instantiateInitialViewController() as? UINavigationController
        return navVc?.viewControllers.first as? Self
    }

    static var storyboardName: String {
        String(describing: Self.self).hasSuffix("VC") ? (String(describing: Self.self) as NSString).replacingOccurrences(of: "VC", with: "") : String(describing: Self.self)
    }
}

public extension UIStoryboard {
    /// SwifterSwift: Instantiate a UIViewController using its class name.
    ///
    /// - Parameter name: UIViewController type.
    /// - Returns: The view controller corresponding to specified class name.
    func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T? {
        return instantiateViewController(withIdentifier: String(describing: name)) as? T
    }
}
