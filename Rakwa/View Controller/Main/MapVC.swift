//
//  MapVC.swift
//  Rakwa
//
//  Created by heba isaa on 25/11/2021.
//

import UIKit
import MapKit
class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationmanager:LocationManager? = nil
    let regionInMeters: Double = 10000
    var screen="classified"
    var lat=""
    var long=""
var Fulladdress = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        setupLocation()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
          
          // mapView is the outlet of map
          mapView.addGestureRecognizer(tapGesture)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        print(Fulladdress)
        if screen == "classified"{
            
            for viewController: UIViewController in (self.navigationController?.viewControllers)!{

                   if (viewController is CreateClassified){

                       let vc: CreateClassified = (viewController as? CreateClassified)!
                       vc.address=Fulladdress
                       vc.lat=lat
                       vc.long=long
                         self.navigationController?.popToViewController(vc, animated: true)
                   }
        }
            
      
        }else  if screen == "profile"{
            for viewController: UIViewController in (self.navigationController?.viewControllers)!{

                   if (viewController is ProfileSetting){

                       let vc: ProfileSetting = (viewController as? ProfileSetting)!
                       vc.buttonText="Address"
                      vc.address=Fulladdress
                       vc.addressFromMap=1
                       

                         self.navigationController?.popToViewController(vc, animated: true)
                   }
        }

        }else if screen == "event"{
            
            for viewController: UIViewController in (self.navigationController?.viewControllers)!{

                   if (viewController is AddEventVC){

                       let vc: AddEventVC = (viewController as? AddEventVC)!
                       vc.addressFromMap=Fulladdress
                       vc.lat=lat
                       vc.long=long
                         self.navigationController?.popToViewController(vc, animated: true)
                   }
        }
            
   

            
            
            
            
        }
    }
    func setupLocation(){
        guard let loc = locationmanager else {return}

     if   LocationManager.shared.isLocationEnabled(){
         mapView.showsUserLocation=true
         loc.getCurrentReverseGeoCodedLocation { location, placemark, error in
             let region = MKCoordinateRegion.init(center: location!.coordinate, latitudinalMeters: self.regionInMeters, longitudinalMeters: self.regionInMeters)
             self.mapView.setRegion(region, animated: true)
         }
        }
   
        
        }
    
    
    
    @objc func handleTap(gestureReconizer: UITapGestureRecognizer) {
            
            let location = gestureReconizer.location(in: mapView)
      
            let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        LocationManager.shared.getAddressFromLatLon(pdblLatitude: "\(coordinate.latitude)", withLongitude: "\(coordinate.longitude)", callback: { status,addresses,country   in
            if status{
                self.Fulladdress=addresses ?? "no clear address"
            }
        })
      
        
        print(Fulladdress)
            // Add annotation:
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            print(" Coordinates ======= \(coordinate)")
    lat = "\(coordinate.latitude)"
        long="\(coordinate.longitude)"
            
            /* to show only one pin while tapping on map by removing the last.
            If you want to show multiple pins you can remove this piece of code */
            if mapView.annotations.count == 1 {
                mapView.removeAnnotation(mapView.annotations.last!)
            }
            mapView.addAnnotation(annotation) // add annotaion pin on the map
        }
      
        }
extension MapVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}

extension MapVC:MKMapViewDelegate{
  
}


   

