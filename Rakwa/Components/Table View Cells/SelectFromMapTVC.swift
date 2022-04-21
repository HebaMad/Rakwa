//
//  SelectFromMapTVC.swift
//  Rakwa
//
//  Created by moumen isawe on 25/12/2021.
//

import UIKit

class SelectFromMapTVC: UITableViewCell,NibLoadableView,ReusableView {

    
    var delegate:SelectFromMapDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func selectFromMapBtnPressed(){
        delegate?.didSelectShowFromMapBtn()
    }

 
    
}
protocol SelectFromMapDelegate{
    func didSelectShowFromMapBtn()
}
