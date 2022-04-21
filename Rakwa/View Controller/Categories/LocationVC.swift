//
//  LocationVC.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class LocationVC: UIViewController {
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var searchBar: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filterVC = FilterResult.instantiate()
          filterVC.modalPresentationStyle = .custom
          filterVC.transitioningDelegate = self
          self.present(filterVC, animated: true, completion: nil)
    }
  
}
extension LocationVC:Storyboarded{
    static var storyboardName: StoryboardName = .Categories
}
extension LocationVC:UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController=DrawerPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.cornerRadius = 20
        presentationController.roundedCorners=[.topLeft,.topRight]
        presentationController.topGap=90
        presentationController.bounce=true

        return presentationController
    }
    
    
}
