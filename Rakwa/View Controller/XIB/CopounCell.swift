//
//  Copoun.swift
//  Rakwa
//
//  Created by macbook on 9/24/21.
//

import UIKit

class CopounCell: UITableViewCell,ReusableView,NibLoadableView {
    @IBOutlet weak var editBtn: MainButton!
    @IBOutlet weak var removeBtn: MainButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var copoundescription: UITextView!
    
    @IBOutlet weak var codeValue: UIButton!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCopoun(copoun:copouns){
        title.text=copoun.coupon_title
        copoundescription.text=copoun.coupon_description
        status.text=copoun.coupon_status
        startDate.text=convertDateFormater(copoun.coupon_start ?? "")
        endDate.text = timeAgo(fullDate: copoun.coupon_end ?? "")
        codeValue.setTitle(" " + copoun.coupon_code! ?? "" ?? "" + "\(copoun.discount_value ?? "")", for: .normal)

    }
    
}
