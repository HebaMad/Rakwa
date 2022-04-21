//
//  NotifivationNotRegisted.swift
//  Rakwa
//
//  Created by macbook on 9/15/21.
//

import UIKit

class NotifivationNotRegisted: UIViewController {

    @IBOutlet var backButton: UIButton!
    @IBOutlet var msg1Error: UILabel!
    @IBOutlet var msg2Error: UILabel!
    @IBOutlet var loginBtn: MainButton!
    @IBOutlet var backBtn: MainButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


}
extension NotifivationNotRegisted:Storyboarded{
    static var storyboardName: StoryboardName = .Categories
}
