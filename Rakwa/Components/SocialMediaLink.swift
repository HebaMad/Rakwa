//
//  SocialMediaLink.swift
//  Rakwa
//
//  Created by macbook on 9/24/21.
//

import UIKit

class SocialMediaLink: UIViewFromNib{
    @IBOutlet private weak var titleTxt: UILabel!
    @IBOutlet private weak var img: UIImageView!
    
    @IBInspectable var image: UIImage? {
         didSet {
             updateView()
         }
     }
    


    @IBInspectable var text1:String?{
        didSet {
            textViewEdit()
        }
      }
    func updateView() {
         img.image = self.image
             
         
     }

    func textViewEdit() {
        titleTxt.text = self.text1
             
         
     }

}
