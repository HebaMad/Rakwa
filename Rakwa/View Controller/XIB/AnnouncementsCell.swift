//
//  AnnouncementsCell.swift
//  Rakwa
//
//  Created by macbook on 9/22/21.
//

import UIKit
import Foundation
import SDWebImage
class AnnouncementsCell: UITableViewCell,ReusableView,NibLoadableView {

    @IBOutlet var imageText: UIImageView!
    @IBOutlet var btnText: UILabel!
    @IBOutlet var link: UILabel!
    @IBOutlet  var descriptionTextf: UITextView!
    @IBOutlet var title: UILabel!
    @IBOutlet var deleteBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureAnnouncement(announcement:Announcement){
        link.text = announcement.btn_link
        btnText.text=announcement.btn_text
        descriptionTextf.text=announcement.description
        imageText.sd_setImage(with: URL(string: announcement.image ?? ""))
    
    }
}
