//
//  DatePickerVC.swift
//  Rakwa
//
// Created by heba isaa on 13/11/2021.
//

import UIKit

enum PickerType {
    case Date
    case Time
    case DateAndTime
    case none
}

protocol DatePickerVCDelegate {
    func didSelectFromPicker(date: Date)
}

class DatePickerVC: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate: DatePickerVCDelegate?
    
    var pickerType: PickerType = .Date
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let loc = Locale(identifier: "uk")
//        datePicker.locale = loc
        
        switch pickerType {
        case .Date:
            datePicker.datePickerMode = .date
        case .DateAndTime:
            datePicker.datePickerMode = .dateAndTime
        case .Time:
            datePicker.datePickerMode = .time
        default:
            break
        }
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        //datePicker.locale = Locale(identifier: "en")

    }

    @IBAction func done(_ sender: UIButton) {
        if let delegate = delegate {
            let pickerValue = datePicker.date
            delegate.didSelectFromPicker(date: pickerValue)
        }
        
        self.dismiss(animated: true, completion: nil)
    }

}

//extension DatePickerVC: UIPickerViewDelegate, UIPickerViewDataSource {
//
//}
