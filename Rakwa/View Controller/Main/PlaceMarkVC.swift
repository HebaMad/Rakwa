//
//  PlaceMarkVC.swift
//  Rakwa
//
//  Created by heba isaa on 06/12/2021.
//

import UIKit
import MapKit

class PlaceMarkVC: UIViewController {
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

    @IBOutlet weak var viewlocation: UIViewDesignable!
    @IBOutlet weak var addressValue: UILabel!
    var lat=""
    var long=""
    var address:String?
    var city:String?
    @IBOutlet weak var countryValue: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        getAddress(lat: lat, long: long)
    }
    

    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension PlaceMarkVC{
    func getAddress(lat:String,long:String){
        LocationManager.shared.getAddressFromLatLon(pdblLatitude: lat, withLongitude: long) { status, msg,country  in
            print(msg)
            print(country)

            self.addressValue.text =  self.address ?? msg ?? " address not found"
            self.countryValue.text = self.city ?? country ?? "country not found"
            let lat: Double = Double("\(lat)")!
            let lon: Double = Double("\(long)")!

            let center = CLLocationCoordinate2DMake(lat, lon)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                               let region = MKCoordinateRegion(center: center, span: span)
                               self.mapView.setRegion(region, animated: true)
                               let annotation = MKPointAnnotation()
                               annotation.coordinate = center
            
//                               if let email = self.userEmail{
//                                   annotation.title = email
//                               }

                               self.mapView.addAnnotation(annotation)

        }
    }
    
  
    }

extension PlaceMarkVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
