//
//  CheckBoxButton.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//


import UIKit

final class CheckBoxButton: UIButton {
           // Images
           let checkedImage = UIImage(named: "open")! as UIImage
           let uncheckedImage = UIImage(named: "uncheck")! as UIImage
           
           
    
           // Bool property
           var isChecked: Bool = false {
               didSet {
                   if isChecked == true {
                       self.setImage(checkedImage, for: UIControl.State.normal)
                   } else {
                       self.setImage(uncheckedImage, for: UIControl.State.normal)
                   }
               }
           }
    
        var onButtonClicked:((Bool) -> ())?
               
           override func awakeFromNib() {
               self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
               self.isChecked = false
           }
               
           @objc func buttonClicked(sender: UIButton) {
               if sender == self {
                   isChecked = !isChecked
                   onButtonClicked?(isChecked)
               }
           }
       }
