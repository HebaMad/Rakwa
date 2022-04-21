//
//  DropDownTVC.swift
//  Rakwa
//
//  Created by moumen isawe on 23/12/2021.
//

import UIKit

class DropDownTVC: UITableViewCell ,ReusableView,NibLoadableView,UITextFieldDataPickerDelegate, UITextFieldDataPickerDataSource{

    

    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var textField:UITextFieldDataPicker!
    var apiKey = ""
    var data = [String](){
        didSet{
            self.textField.reloadData()
        }
    }
    var onReciveData:onReciveData!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.pickerDelegate = self
        textField.dataSource = self
        // Initialization code
    }

    func textFieldDataPicker(_ textField: UITextFieldDataPicker, didSelectRow row: Int, inComponent component: Int) {
        onReciveData(self.apiKey,self.data[row])
        self.textField.text = self.data[row]
    }
    
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, numberOfRowsInComponent component: Int) -> Int {
        return self.data.count
    }
    
    func textFieldDataPicker(_ textField: UITextFieldDataPicker, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.data[row]
    }
    
    func numberOfComponents(in textField: UITextFieldDataPicker) -> Int {
        return 1
    }
    
}
typealias onReciveData = ((String,String) -> ())
typealias onReciveImage = ((String,UIImage) -> ())
