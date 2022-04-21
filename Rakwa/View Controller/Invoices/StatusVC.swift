//
//  StatusVC.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class StatusVC: UIViewController {

    @IBOutlet var back: UIButton!
    @IBOutlet var wrongImage: UIImageView!
    @IBOutlet var successImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func invoicesBtn(_ sender: Any) {
    }


}
