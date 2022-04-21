//
//  NotRegisted.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class NotRegisted: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func loginBtn(_ sender: Any) {
        sceneDelegate.setRootVC(vc: LoginVC.instantiate())
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension NotRegisted:Storyboarded{
    static var storyboardName: StoryboardName = .Contact
}
