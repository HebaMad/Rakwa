//
//  TextAreaTVC.swift
//  Rakwa
//
//  Created by moumen isawe on 23/12/2021.
//

import UIKit

class TextAreaTVC: UITableViewCell,UITextViewDelegate ,ReusableView,NibLoadableView{
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var textView:UITextView!
    var apiKey = ""
    var onReciveData:onReciveData!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textView.delegate = self
        textView.roundCorners([.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner], radius: 12)
        textView.setBorder(with: UIColor(named: "Border")!, width: 1)
    }
 
    func textViewDidEndEditing(_ textView: UITextView) {
        self.onReciveData(self.apiKey,textView.text)
    }
}
