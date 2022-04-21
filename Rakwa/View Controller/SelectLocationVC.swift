//
//  SelectLocationVC.swift
//  Rakwa
//
//  Created by moumen isawe on 19/12/2021.
//

import UIKit
import MapKit
final class SelectLocationVC: UIViewController {
    @IBOutlet weak var mapView:MKMapView!
    var onSelectLocation:((CLLocationCoordinate2D)->())? = nil
    var selectedLocation:CLLocationCoordinate2D? = nil
    let heldPoint = MKPointAnnotation()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(createNewAnnotation))

        longPressGesture.minimumPressDuration = 0.10

        mapView.addGestureRecognizer(longPressGesture)
        mapView.addAnnotation(heldPoint)

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @objc func createNewAnnotation(_ sender: UIGestureRecognizer) {
    let touchPoint = sender.location(in: self.mapView)

    let coordinates = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)


    heldPoint.coordinate = coordinates
        selectedLocation = coordinates

//    if (sender.state == .began) {
//
//
//    mapView.addAnnotation(heldPoint)
//
//    }

    // Cancel the long press to make way for the next gesture

    sender.state = .cancelled

    }
    
    @IBAction func useMyLocationBtnPressed(){
        
        LocationManager.shared.getLocation { location, error in
            if let error = error {
                self.showNoLocationVC()
                return
            }
            guard let location = location else { return}
            self.onSelectLocation?(location.coordinate)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func endVC(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmSelectedLocation(){
        if let selectedLocation = selectedLocation {
            self.onSelectLocation?(selectedLocation)
            self.navigationController?.popViewController(animated: true)
        }else{
            self.showAlert(title: "Warning", message: "You need to select location",hideCancelBtn: true)
        }
        
        
    }
}
