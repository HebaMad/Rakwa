//
//  RoundedImageView.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import UIKit
@IBDesignable class RoundedImageView:UIImageView {
    @IBInspectable var color: UIColor = .clear {
        didSet {
            updateView()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
      }
    func updateView(){
        layer.borderWidth = 1
        layer.borderColor = color.cgColor
    }
}
