//
//  Date+Extension.swift
//  Rakwa
//
//  Created by heba isaa on 13/11/2021.
//

import Foundation
//import SwiftDate
import UIKit

extension Date {
    //Helpful Link:
    //https://stackoverflow.com/a/33343958

    func getDDMMYYYY(dates:Date) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        dateFormatter.locale = Locale(identifier: "en_us")
        
        let date = dateFormatter.date(from:"\(dates)")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: dates )
    }
    
    func getYYYYMMDD2() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss z"
        dateFormatter.locale = Locale(identifier: "en_us")
        let date = dateFormatter.date(from: self.description)
        dateFormatter.dateFormat = "HH:mm z"
        return dateFormatter.string(from: date!)
    }
    
    
    func getTimeOnly() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss z"
        dateFormatter.locale = Locale(identifier: "en_us")
        let date = dateFormatter.date(from: self.description)
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: date!)
    }
    
    var totalSeconds:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())/1000
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

