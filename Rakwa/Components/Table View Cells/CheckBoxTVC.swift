//
//  CheckBoxTVC.swift
//  Rakwa
//
//  Created by moumen isawe on 24/12/2021.
//

import UIKit

final class CheckBoxTVC: UITableViewCell ,ReusableView,NibLoadableView{
    
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var checkBox:CheckBoxButton!
    var apiKey = ""
    var onButtonClicked:((String,Bool) -> ())?
    
      
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkBox.onButtonClicked = { [weak self] newVal in
            
             
            self?.onButtonClicked?(self?.apiKey ?? "",newVal)
        }
    }

 
}
