//
//  DiscoverVC.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit
import SDWebImage
class DiscoverVC: UIViewController {


    @IBOutlet var discoverTitle: UILabel!
    @IBOutlet var time: UILabel!
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var bodyText: UITextView!
    
    var discoverItem:DiscoverItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true

        discoverTitle.text=discoverItem?.title
        image.sd_setImage(with:URL(string:discoverItem?.image ?? ""))
        bodyText.text=discoverItem?.detaildesc
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)    }

}
extension DiscoverVC:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
