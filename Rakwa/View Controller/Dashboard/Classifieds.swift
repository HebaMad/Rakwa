//
//  Classifieds.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class Classifieds: UIViewController {
    
    @IBOutlet var backgroundImg: UIImageView!
    @IBOutlet var ClassifiesTitle: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var body: UITextView!
    @IBOutlet var locationAddress: UILabel!
    
    var details:ClassifiedDetails?
    var lat=""
    var long=""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let classifiedDetails=details else{return}
        backgroundImg.sd_setImage(with:URL(string:classifiedDetails.image ?? "" ))
        body.text=classifiedDetails.description
        ClassifiesTitle.text=classifiedDetails.title
        location.text="\(classifiedDetails.location?.state) - \(classifiedDetails.location?.city)"
        locationAddress.text=classifiedDetails.location?.address

        
    }
    
    @IBAction func viewLocBtn(_ sender: Any) {
        let vc = PlaceMarkVC.instantiate()
        vc.lat=details?.location?.latitude ?? ""
        vc.long=details?.location?.longitude ?? ""
        vc.city=(details?.location?.city ?? "") + (details?.location?.state ?? "")
        vc.address=details?.location?.address ?? ""
        navigationController?.pushViewController(vc, animated: true)

    }

    
    @IBAction func shareBtn(_ sender: Any) {
        
        
        
    }

    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
}
extension Classifieds:Storyboarded{
    static var storyboardName: StoryboardName = .Dashboard
}
extension Classifieds{
    
    
    func favCreated(listingId:Int,callback: @escaping CallbackCheck){
        self.showActivityIndicator()

        HomeManager.shared.createFavourite(listingId: listingId) { response in

            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                
                do {
                    self.showAlert(title: "Success", message:response.statusMessage)
                    callback(true)

                } catch let error {
                    self.showAlert(title: "Error", message:response.statusMessage)
                    callback(false)

                }
                }
            case let .failure(error):
                callback(false)

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
            
        }
        self.hideActivityIndicator()

        
        
    }
    
    func deleteFav(listingID:Int,  callback: @escaping CallbackCheck)->Void{
        self.showActivityIndicator()

        HomeManager.shared.deleteFavourite(listingId: listingID) { response in

            switch response{
            case let .success(response):
                if response.statusCode == 200{
                    
                do {
                    self.showAlert(title: "Success", message:response.statusMessage)

                    callback(true)
                } catch let error {
                    self.showAlert(title: "Error", message:response.statusMessage)
                    callback(false)

                }
                }
            case let .failure(error):
                
                callback(false)

                self.showAlert(title:  "Notice", message: "\(error)", confirmBtnTitle: "Try Again", cancelBtnTitle: nil, hideCancelBtn: true) { (action) in
                
                }
        }
        }
        self.hideActivityIndicator()

    }
    
    
    
}
