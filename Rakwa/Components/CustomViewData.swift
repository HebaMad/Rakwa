//
//  CustomViewData.swift
//  Rakwa
//  Created by macbook on 9/20/21.

import UIKit

class CustomViewData: UIViewFromNib {
    
    @IBOutlet private  weak var valueTxt: UILabel!
    @IBOutlet private weak var titleTxt: UILabel!
    @IBOutlet private weak var img: UIImageView!
    
    @IBInspectable var image: UIImage? {
         didSet {
             updateView()
         }
     }
    
    @IBInspectable var text:String?{
        didSet {
        textViewEdit()
      }
    }

    func updateView() {
         img.image = self.image
             
         
     }
    func textViewEdit() {
        titleTxt.text = self.text
             
         
     }

}
