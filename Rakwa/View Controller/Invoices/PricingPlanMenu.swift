//
//  PricingPlanMenu.swift
//  Rakwa
//
//  Created by macbook on 10/5/21.
//

import Foundation
import UIKit


enum pricePlanMenu{
    case MyListings
    case Inbox

    case Invoices
    case Saved
    case Reviews
    case Coupons

    case Events
    case packages
    case menus
    case Ad_campaigns
    case Announcements
    case Classifieds

    
    
    var labelName:String{
        
        switch self {
        case .MyListings:
            return "My Listings"

        case .Inbox:
            return "Inbox"

        case .Invoices:
            return "Invoices"

        case .Saved:
            return "Saved"

        case .Reviews:
            return "Reviews"

        case .Coupons:
            return "Coupons"

        case .Events:
            return "Events"

        case .packages:
            return "packages"

        case .menus:
            return "Menus"

        case .Ad_campaigns:
            return "Ad campaigns"
        case .Announcements:
            return "Announcements"
        case .Classifieds:
            return "Classifieds"
            
        }
    }
    var imgName:UIImage?{


        switch self {
        case .MyListings:
            return UIImage(named: "Listing")
        case .Inbox:
            return UIImage(named: "inbox")
        case .Invoices:
            return UIImage(named: "invoices")
        case .Saved:
            return UIImage(named: "saved")
        case .Reviews:
            return UIImage(named: "reviews")
        case .Coupons:
            return UIImage(named: "copoun")
        case .Events:
            return UIImage(named: "event")
        case .packages:
            return UIImage(named: "packages")
        case .menus:
            return UIImage(named: "menu")
        case .Ad_campaigns:
            return UIImage(named: "adCampaicans")
        case .Announcements:
            return UIImage(named: "Hot")
        case .Classifieds:
            return UIImage(named: "classifieds")
        }
    }

}
