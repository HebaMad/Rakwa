//
//  MainLabel.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import UIKit

@IBDesignable
final class MainLabel: UILabel {
    @IBInspectable var color: UIColor? =  UIColor(hex: "242424"){
        didSet{
            self.textColor = color
        }
    }
    public override func awakeFromNib() {
           super.awakeFromNib()
           configureLabel()
       }

       public override func prepareForInterfaceBuilder() {
           super.prepareForInterfaceBuilder()
           configureLabel()
       }

       func configureLabel() {
           font = UIFont(name: "Roboto-Regular", size: self.font.pointSize)
        

       }

}
 
 
