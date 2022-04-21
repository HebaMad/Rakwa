//
//  TextFieldTVC.swift
//  Rakwa
//
//  Created by moumen isawe on 23/12/2021.
//

import UIKit

class TextFieldTVC: UITableViewCell, UITextFieldDelegate , NibLoadableView,ReusableView{
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var textField:UITextField!
    var apiKey = ""
    var onReciveData:onReciveData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.onReciveData(apiKey,textField.text ?? "")
    }
    
}
