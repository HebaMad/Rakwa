//
//  ColorSystem.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import Foundation


import UIKit
 
enum Color: String, CaseIterable {
    //Base Colors
    case primary = "Primary"
    case appPrimary = "AppPrimary"
    case buttonPrimary = "btn"
    case lightPrimary = "Light Primary"
    case tabBarTint = "TabBarTint"
    case notificationBorder = "NotificationBorder"
    case secondary = "Secondary"
    case profileCellBorder = "ProfileCellBorder"
    case error = "Error"

    // Text Colors
    case textPrimary = "Text Primary"
    case textSecondary = "Text Secondary"

    //Background Colors
    case backgroundPrimary = "Background Primary"
    case backgroundSecondary = "Background Secondary"
    case background = "background"
    
  
}
extension UIColor {
    convenience init?(color: Color) {
        self.init(named: color.rawValue)
    }
}
//UIColor(color: .textPrimary)
