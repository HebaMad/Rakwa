//
//  BannerHeroTextCollectionViewCell.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 30/08/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import SDWebImage
class BannerCell: UICollectionViewCell,ReusableView,NibLoadableView {


        
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configureBanner(_ item: Banner) {
        titleLabel.text = item.title
        imageView.sd_setImage(with:URL(string:item.image ?? ""))

    }

}
