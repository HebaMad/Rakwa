//
//  ProfileUserAccounts.swift
//  Rakwa
//
//  Created by macbook on 10/1/21.
//

import UIKit

class ProfileUserAccounts: UIViewController {

    @IBOutlet var facebookView: SocialMediaLink!
    @IBOutlet var instagramView: SocialMediaLink!
    @IBOutlet var linkedinView: SocialMediaLink!
    @IBOutlet var penterestView: SocialMediaLink!
    @IBOutlet var twitterView: SocialMediaLink!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
extension ProfileUserAccounts:Storyboarded{
    static var storyboardName: StoryboardName = .main
}
