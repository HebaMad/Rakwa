//
//  NoLocationVC.swift
//  Rakwa
//
//  Created by moumen isawe on 19/12/2021.
//

import UIKit
import MapKit

class NoLocationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in

                    if let error = error {
                         return
                    }
                    
            guard let location = location else {return}
            self.dismiss(animated: true, completion: nil)
            }
    }
    
    @IBAction func verifyLocationPermission(){
        LocationManager.shared.getLocation { (location:CLLocation?, error:NSError?) in

                    if let error = error {
                         return
                    }
                    
            guard let location = location else {
                        self.showAlert(title: "Location Permission Required", message: "You should activate your location ", confirmBtnTitle: "OK", cancelBtnTitle: "", hideCancelBtn: true) { (action) in
                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
                        }
                        return
                    }
            self.dismiss(animated: true, completion: nil)
            
            
            
         
          
                }
    }
    
 
    
}
