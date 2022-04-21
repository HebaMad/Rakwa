//
//  MyListingTVC.swift
//  Rakwa
//
//  Created by macbook on 9/16/21.
//

import UIKit
import SDWebImage
class MyListingTVC: UITableViewCell,ReusableView,NibLoadableView {


    @IBOutlet weak var listingRate: RatingControl!
    @IBOutlet weak var associatedPlan: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var seenNum: MainButton!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var removeListing: UIButton!
    @IBOutlet weak var editListingBtn: UIButton!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var expieryDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureList(data:ListingData){
        listingRate.rating=data.rating ?? 0
        title.text=data.title
        status.text = data.status
        startDate.text = convertDateFormater(data.start_date?.date ?? "")
        expieryDate.text = timeAgo(fullDate: data.end_date?.date ?? "") 
        seenNum.setTitle("\(data.views ?? 0)", for: .normal)
        background.sd_setImage(with:URL(string:data.image ?? ""))
        rating.text = "\(data.rating ?? 0)"
        associatedPlan.text=data.associated_plan


    }

}
