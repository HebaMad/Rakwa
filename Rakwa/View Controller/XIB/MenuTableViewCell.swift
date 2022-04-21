//
//  MenuTableViewCell.swift
//  Sayarat
//
//  Created by macbook on 3/10/21.
//

import UIKit

class MenuTableViewCell: UITableViewCell,ReusableView,NibLoadableView {


    @IBOutlet var imgName: UIImageView!
    @IBOutlet var labelName: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
