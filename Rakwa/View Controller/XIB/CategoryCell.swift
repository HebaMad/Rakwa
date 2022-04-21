//
//  GridItemCollectionViewCell.swift
//  AppStoreCompositionalLayout
//
//  Created by Alfian Losari on 11/11/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import UIKit
import SDWebImage
class CategoryCell: UICollectionViewCell,ReusableView,NibLoadableView {

    @IBOutlet weak var categoryView: UIViewDesignable!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    func configureCategories(item: TopCategory) {
        textLabel.text = item.title
        img.sd_setImage(with:URL(string:item.icon ?? ""))

    }
}


