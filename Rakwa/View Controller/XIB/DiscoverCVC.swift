//
//  DiscoverCVC.swift
//  Rakwa
//
//  Created by macbook on 9/10/21.
//

import UIKit
import SDWebImage
class DiscoverCVC: UITableViewCell,ReusableView,NibLoadableView {

    @IBOutlet var titleL: UILabel!
    @IBOutlet var backgroundImg: UIImageView!
    @IBOutlet var timeL: UILabel!
    @IBOutlet var detailsL: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureDiscover(Discover:DiscoverItem){
        backgroundImg.sd_setImage(with:URL(string:Discover.image ?? ""))
        titleL.text = Discover.title
        detailsL.text = Discover.summarydesc


    }
}
