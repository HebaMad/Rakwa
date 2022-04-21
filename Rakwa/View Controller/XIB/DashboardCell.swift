//
//  DashboardCell.swift
//  Rakwa
//
//  Created by macbook on 9/15/21.
//

import UIKit

class DashboardCell: UICollectionViewCell,ReusableView,NibLoadableView {

    @IBOutlet var img: UIImageView!
    @IBOutlet var Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
