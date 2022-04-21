//
//  MenuItem.swift
//  Rakwa
//
//  Created by macbook on 10/5/21.
//

import Foundation
import UIKit

enum MenuItem{
   static let all = [MyListings,Invoices,Saved,Reviews,ContactUs]
    
 
    case MyListings
    case Invoices
    case Saved
    case Reviews
    case ContactUs


  
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
        case .ContactUs:
            return "Contact Us"


        }
    }
    
    var imgName:UIImage?{


        switch self {

        case .MyListings:
            return UIImage(named: "myListing1")
   
        case .Invoices:
            return UIImage(named: "invoices1")
        case .Saved:
            return UIImage(named: "saved1")
        case .Reviews:
            return UIImage(named: "reviews1")
        case .ContactUs:
            return UIImage(named: "contactus1")

     
        }
    }
    
 
}
