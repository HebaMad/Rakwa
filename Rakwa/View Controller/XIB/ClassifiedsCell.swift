//
//  ClassifiedsCell.swift
//  Rakwa
//
//  Created by macbook on 9/29/21.
//

import UIKit
import SDWebImage
class ClassifiedsCell: UITableViewCell,ReusableView,NibLoadableView {

    @IBOutlet var title: UILabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var removeBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureClassified(classified:ClassifiedData){
     
        title.text=classified.title
        subTitle.text=classified.description ?? ""+"\(classified.category ?? "")"
        img.sd_setImage(with:URL(string:classified.image ?? ""))


    }
}
