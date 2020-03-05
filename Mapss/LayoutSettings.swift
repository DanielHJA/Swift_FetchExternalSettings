//
//  LayoutSettings.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-05.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class LayoutSettings: NSObject {
    static let shared = LayoutSettings()
    override private init() { }
    
    var hasLayoutSettings: Bool {
        return layoutSettingsObject != nil
    }
    
    var layoutSettingsObject: LayoutSettingsObject?
    
    var standardFont: UIFont {
        if let layoutSettingsObject = layoutSettingsObject {
            return UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: layoutSettingsObject.font))
        } else {
            return UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        }
    }
    
    var standardColor: UIColor {
        if let layoutSettingsObject = layoutSettingsObject {
            return UIColor(hexFromString: layoutSettingsObject.textColor)
        } else {
            return Colors.textColor
        }
    }
    
}

struct Colors {
    static var textColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { (trait) -> UIColor in
                return trait.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            }
        }
        else { return UIColor.black }
    }
}
