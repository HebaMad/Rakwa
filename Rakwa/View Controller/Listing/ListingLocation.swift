//
//  ListingLocation.swift
//  Rakwa
//
//  Created by macbook on 9/18/21.
//

import UIKit
import MapKit
class ListingLocation: UIViewController {
    @IBOutlet var backBtn: UIButton!
    
    @IBOutlet var searchBar: SearchView!
    @IBOutlet var address: UILabel!
    @IBOutlet var locttitle: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var status: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func viewAllrivewesBtn(_ sender: Any) {
    }
    @IBAction func submit(_ sender: Any) {
    }
    
    @IBAction func useMyLocationBtn(_ sender: Any) {
    }
}
extension ListingLocation:Storyboarded{
    static var storyboardName: StoryboardName = .Contact
}
