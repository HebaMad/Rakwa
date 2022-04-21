//
//  Paypal.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class Paypal: UIViewController {

    @IBOutlet var firstName: MainTF!
    @IBOutlet var lastName: MainTF!
    @IBOutlet var email: MainTF!
    @IBOutlet var phone: MainTF!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func linkBtn(_ sender: Any) {
    }
    
    @IBAction func save(_ sender: Any) {
    }
    @IBAction func backBtn(_ sender: Any) {
    }
}
extension Paypal:Storyboarded{
    static var storyboardName: StoryboardName = .Invoices
}
