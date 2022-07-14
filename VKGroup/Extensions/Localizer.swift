//
//  Localizer.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import Foundation

class Localizer: NSObject {
    
    static var defaultLanguage = "en"
    fileprivate static var theSwizzlingDided = false
    
    class func DoTheSwizzling() {
        if !theSwizzlingDided {
            theSwizzlingDided = true
            MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        }
    }
}

extension String {
    var localized : String {
        if self == "LANG" {
            let lang = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as? String
            if lang?.hasPrefix("ru") ?? false {
                return "ru"
            }
            else if lang?.hasPrefix("uk") ?? false {
                return "uk"
            }
            return lang ?? "en"
        }
        return localizedString(self)
    }
}

// локализованная строка
func localizedString(_ stringToLocalize: String) -> String
{
    if let lang = UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first, let path = Bundle.main.path (forResource: lang, ofType: "lproj"), let languageBundle = Bundle(path: path) {
        
        return languageBundle.localizedString (forKey: stringToLocalize, value: nil, table: nil)
        
    } else {
        // тут вызываем старый метод локализации (из-за подмены нужно вызвать новый)
        if Localizer.theSwizzlingDided {
            return Bundle.main.specialLocalizedStringForKey(stringToLocalize, value: nil, table: nil)
        }
        else {
            return Bundle.main.localizedString(forKey: stringToLocalize, value: nil, table: nil)
        }
    }
}


extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            // если есть значение по-умолчанию (как для storyboard)
            // пробуем локализовать с помощью localizedString
            if let value = value, value.count > 0 {
                let localized = value.localized
                // если изменилось - значит есть перевод в основном файле локализации
                if localized != value {
                    // используем значение оттуда
                    return localized
                }
            }
            // не получилось локализовать - пробуем взять из файла локализации соответствующей storyboard
            let currentLanguage = "LANG".localized
            var bundle = Bundle();
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } else {
                let _path = Bundle.main.path(forResource: Localizer.defaultLanguage, ofType: "lproj")!
                bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

/// Exchange the implementation of two methods of the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    guard let origMethod: Method = class_getInstanceMethod(cls, originalSelector),
        let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector) else {
        return
    }
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
