//
//  ADCampigansCell.swift
//  Rakwa
//
//  Created by macbook on 9/22/21.
//

import UIKit

class ADCampigansCell: UITableViewCell,ReusableView,NibLoadableView {

    @IBOutlet var backgroundImg: UIImageView!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var seenBtn: UIButton!
    
    @IBOutlet var expireDate: UILabel!
    @IBOutlet var startDate: UILabel!
    @IBOutlet var status: UILabel!
    
    
    @IBOutlet var removeAdBtn: UIButton!
    @IBOutlet var editAdBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureAdCampaign(adCampaign:AdCampaign){
     
        title.text=adCampaign.title
        status.text=adCampaign.status
        expireDate.text = adCampaign.endDate.date
        startDate.text = adCampaign.startDate.date

    }
    
}
