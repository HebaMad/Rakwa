//
//  HomeCVC.swift
//  Rakwa
//
//  Created by macbook on 9/10/21.
//

import UIKit
import SDWebImage
class HomeCell: UITableViewCell,ReusableView,NibLoadableView {

    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var rate: RatingControl!
    @IBOutlet var backgroundImg: UIImageView!
    @IBOutlet var titleL: UILabel!
    @IBOutlet var statusBtn: UIButton!
    @IBOutlet var timeL: UILabel!
    @IBOutlet var locationL: UILabel!
    @IBOutlet var detailsL: UILabel!
    @IBOutlet var callBtn: UIButton!
    @IBOutlet var viewLocationBtn: UIButton!
    @IBOutlet var favBtn: UIButton!
    @IBOutlet var loveV: UIViewDesignable!
    @IBOutlet var placeL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureHome(listing: LatestListing) {
        placeL.text=listing.category?.title
        rate.isEnabled=false
        rate.rating=listing.rating ?? 0
        backgroundImg.sd_setImage(with:URL(string:listing.image ?? ""))
        callBtn.setTitle("Call \(listing.phone ?? "")", for: .normal)
        titleL.text = listing.title
        locationL.text = listing.address
        detailsL.text = listing.description
        if listing.status == 1 {
            statusBtn.setTitle(" open now ", for: .normal)
            statusBtn.backgroundColor = UIColor(named: "statusBtn")

        }else{
            statusBtn.setTitle(" closed now ", for: .normal)
            statusBtn.backgroundColor = .red

        }
        
        if listing.isFavorite == 1{
            favBtn.tintColor = .red
        }else{
            favBtn.tintColor = .white

        }
        
        
        if listing.address == nil || listing.address == ""{
            locationIcon.isHidden=true
        }
        
    }
    
  
    
}
