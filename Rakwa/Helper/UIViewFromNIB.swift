//
//  UIViewFromNIB.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//


import UIKit

class UIViewFromNib: UIView {

   var contentView: UIView!

   var nibName: String {
       return String(describing: type(of: self))
   }

   //MARK:
   override init(frame: CGRect) {
       super.init(frame: frame)

       loadViewFromNib()
   }

   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)

       loadViewFromNib()
   }

   //MARK:
   func loadViewFromNib() {
       contentView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?[0] as! UIView
       contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
       contentView.frame = bounds
       addSubview(contentView)
   }
}
