//
//  NextAndBackView.swift
//  Rakwa
//
//  Created by moumen isawe on 24/12/2021.
//

import UIKit

class NextAndBackView: UIViewFromNib {
    @IBOutlet weak var nextBtn:UIButton!
    @IBOutlet weak var backBtn:UIButton!
    
    var delegeta:NextBackDelegate?

    @IBAction func nextBtnPressed(){
        delegeta?.nextBtnPressed()
    }
    
    
    @IBAction func backBtnPressed(){
        delegeta?.backBtnPressed()
    }
     
}



protocol NextBackDelegate{
    func nextBtnPressed()
    func backBtnPressed()
}
