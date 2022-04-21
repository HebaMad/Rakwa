//
//  PaymentMethodSelection.swift
//  Rakwa
//
//  Created by heba isaa on 09/12/2021.
//

import UIKit

class PaymentMethodSelection:UIViewFromNib{

    @IBOutlet private weak var titleTxt: UILabel!
    @IBOutlet private weak var img: UIImageView!
    
    @IBOutlet weak var btnSelect: UIButton!
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
