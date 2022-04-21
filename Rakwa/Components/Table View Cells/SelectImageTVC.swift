//
//  SelectImageTVC.swift
//  Rakwa
//
//  Created by moumen isawe on 24/12/2021.
//

import UIKit

class SelectImageTVC: UITableViewCell ,ReusableView,NibLoadableView{
    
    @IBOutlet weak var titleLbl:UILabel!
    
    weak var imagePicker: ImagePicker!
    var onSelectImage:((UIImage)->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    @IBAction func showImagePicker(_ sender: UIButton) {
           self.imagePicker.present(from: sender)
       }
    
    
}
extension SelectImageTVC:ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        if let image = image {
            self.onSelectImage?(image)
        }
        
      }
}
