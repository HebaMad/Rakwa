//
//  DashboardMenu.swift
//  Rakwa
//
//  Created by macbook on 9/21/21.
//

import Foundation
import UIKit


enum DashboardMenuItems{
    static let all = [MyListings,Invoices,Saved,Reviews,Coupons,Events,Ad_campaigns,Announcements,Classifieds]

    case MyListings

    case Invoices
    case Saved
    case Reviews
    case Coupons

    case Events

    case Ad_campaigns
    case Announcements
    case Classifieds

    
    
    var labelName:String{
        
        switch self {
        case .MyListings:
            return "My Listings"

 
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

        case .Ad_campaigns:
            return UIImage(named: "adCampaicans")
        case .Announcements:
            return UIImage(named: "Hot")
        case .Classifieds:
            return UIImage(named: "classifieds")
        }
    }

}
