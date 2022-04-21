//
//  PaymentMethod.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class PaymentMethod: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func paypalLink(_ sender: Any) {
    }
    
    @IBAction func creditCardLink(_ sender: Any) {
    }
    
    @IBAction func stripeBtn(_ sender: Any) {
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension PaymentMethod:Storyboarded{
    static var storyboardName: StoryboardName = .Invoices
}
