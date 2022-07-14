//
//  UIApplication.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

extension UIApplication {
    
    class func open(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    class func topViewController() -> UIViewController? {
        
        if var vc = UIApplication.shared.windows.last?.rootViewController {
            
            if vc is UITabBarController{
                vc = (vc as! UITabBarController).selectedViewController!
            }
            
            if vc is UINavigationController{
                vc = (vc as! UINavigationController).topViewController!
            }
            
            while ((vc.presentedViewController) != nil &&
                (String(describing: type(of: vc.presentedViewController!)) != "SFSafariViewController") &&
                (String(describing: type(of: vc.presentedViewController!)) != "UIAlertController")) {
                    vc = vc.presentedViewController!
                    if vc is UINavigationController{
                        vc = (vc as! UINavigationController).topViewController!
                    }
            }
            
            return vc;
            
        } else {
            return nil
        }
        
    }
    
}

fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
