//
//  ReviewRecievedCell.swift
//  Rakwa
//
//  Created by macbook on 9/20/21.
//

import UIKit
import SDWebImage
class ReviewRecievedCell: UITableViewCell,ReusableView,NibLoadableView {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var ratingComment: UILabel!
    @IBOutlet weak var userPic: RoundedImageView!
    @IBOutlet weak var ratingBar: RatingControl!
    @IBOutlet weak var ratingUserName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureReview(item:Received){
        userPic.sd_setImage(with: URL(string:item.reviews[0].reviewer_image ?? ""))
        ratingUserName.text=item.reviews[0].reviewer_name
        ratingComment.text=item.reviews[0].message ?? ""
        ratingBar.rating=item.reviews[0].rating ?? 0
    }
    
}
