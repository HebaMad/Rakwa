//
//  SavedCell.swift
//  Rakwa
//
//  Created by macbook on 10/2/21.
//

import UIKit
import SDWebImage
class SavedCell: UICollectionViewCell,ReusableView,NibLoadableView {

    @IBOutlet weak var ratingFavCategory: RatingControl!
    @IBOutlet weak var category: MainLabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var backdroundImg: UIImageViewDesignable!
    @IBOutlet weak var favBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureSavedData(item:favData){
        backdroundImg.sd_setImage(with: URL(string: item.listing?.image ?? ""))
        title.text=item.listing?.title ?? ""
        category.text=item.listing?.category?.title ?? ""
        ratingFavCategory.rating=item.listing?.rating ?? 0
    }

}
