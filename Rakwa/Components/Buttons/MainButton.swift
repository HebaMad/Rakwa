//
//  MainButton.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import UIKit
final class MainButton: UIButton {
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.black
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        setup()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
      }
    
    private func setup(){
//        self.backgroundColor = UIColor(named: "btn")
        self.layer.cornerRadius = self.frame.height/4
        self.layer.masksToBounds = true
        self.setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont(name: "Roboto-Regular", size: self.titleLabel!.font.pointSize)
        
        
    }
    
    
  
}




final class SecondaryButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        setup()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      }
    
    private func setup(){
//        self.setTitleColor(UIColor(color: .textPrimary), for: .normal)
        titleLabel?.font = UIFont(name: "Roboto-Regular", size: self.titleLabel!.font.pointSize)
    }
    
    
  
}


