//
//  StoryBoarded.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

 import UIKit


 
enum StoryboardName: String {
    case main = "Main"
    case auth = "Auth"
    case Categories = "Categories"
    case Listing = "Listing"
    case Dashboard = "Dashboard"
    case Contact = "Contact"
    case Invoices = "Invoices"
    case Copoun = "Copoun"
    case Announcements = "Announcements"
    case AdCampaigns = "AdCampaigns"

}

protocol Storyboarded {
    static var storyboardIdentifier: String { get }
    static var storyboardName: StoryboardName { get }
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    static var storyboardName: StoryboardName {
        return .main
    }

    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
    
}
