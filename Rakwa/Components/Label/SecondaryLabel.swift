//
//  SecondaryLabel.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import UIKit
@IBDesignable
final  class SecondaryLabel: UILabel {

    @IBInspectable var color: UIColor? =  UIColor(hex: "242424"){
        didSet{
            self.textColor = color
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLabel()
    }

       func configureLabel() {
        
        
            font = UIFont(name: "Roboto-Medium", size: self.font.pointSize)
        }

}
