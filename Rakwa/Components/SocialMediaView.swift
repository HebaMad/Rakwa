//
//  SocialMediaView.swift
//  Rakwa
//
//  Created by macbook on 9/20/21.
//

import UIKit

class SocialMediaView: UIViewFromNib {

    @IBOutlet private  weak var valueTxt: UILabel!
    @IBOutlet private weak var titleTxt: UILabel!
    @IBOutlet private weak var img: UIImageView!
    
    @IBInspectable var image: UIImage? {
         didSet {
             updateView()
         }
     }
    
    @IBInspectable var text2:String?{
        didSet{
            textViewEdit2()
        }
      }

    @IBInspectable var text1:String?{
        didSet{
            textViewEdit1()
        }
      }
    func updateView() {
         img.image = self.image
          
     }
    func textViewEdit2() {
        titleTxt.text = self.text2
             
         
     }
    func textViewEdit1() {
        valueTxt.text = self.text1
             
         
     }
}
