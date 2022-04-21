//
//  AddListingHeader.swift
//  Rakwa
//
//  Created by moumen isawe on 24/12/2021.
//

import UIKit

class AddListingHeader: UIViewFromNib {

  @IBOutlet weak var progressView:ProgressView!
     
    
    
    
    func numberOfSteps(number:Int){
        progressView.setNumberOfStep(number)
    }
    func nextStep(title:String){
        progressView.nextStep()
        progressView.titleLbl.text = title
    }
    func previousStep(title:String){
        progressView.previousStep()
        progressView.titleLbl.text = title
    }

}
