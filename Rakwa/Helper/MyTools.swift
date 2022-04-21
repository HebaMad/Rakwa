//
//  MyTools.swift
//  Rakwa
//
//  Created by heba isaa on 24/11/2021.
//


import UIKit
//import ARSLineProgress
import SystemConfiguration
import AVFoundation
import AVKit
//import SCLAlertView


class MyTools: NSObject {
    static var tool = MyTools()
    
    func coonectInterntBasim () ->Void {
        
        
//                if let topVC = getTopViewController() {
//
//                }
        
    }
    func errorInterntBasim () ->Void {
      
        //        if let topVC = getTopViewController() {
        //
        //
        //
        //        }
    }
    
    

    
    // MARK: - Color With Hex
    func getColorByHex(rgbHexValue:UInt32) -> UIColor {
        let red = Double((rgbHexValue & 0xFF0000) >> 16) / 256.0
        let green = Double((rgbHexValue & 0xFF00) >> 8) / 256.0
        let blue = Double((rgbHexValue & 0xFF)) / 256.0
        
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(1))
    }
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    func leftView (textField:UITextField) -> Void {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 15, height: textField.frame.size.height)
        textField.leftView = leftView
        textField.leftViewMode = .always
    }
    
    func setViewStyle(view:UIView) -> Void {
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor.white
    }
    
//
//
    func hideBackWord(navItem : UINavigationItem) -> Void {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navItem.backBarButtonItem = backItem
        
    }
    
    func getCurrentDate() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        let today = formatter.string(from: Date())
        return today
    }
    
    func convertDateToString(_ date: Date) -> String {
        let formater = DateFormatter()
        formater.locale = NSLocale(localeIdentifier: "en") as Locale?
        formater.dateFormat = "d' 'MMMM' 'yyyy'"
        return formater.string(from: date)
    }
    
    
    func getMyId(key:String) -> String {
        let ns = UserDefaults.standard
        var idd : String = ""
        if  let dict = ns.value(forKey: "CurrentUser"){
            let id = (dict as! NSDictionary).value(forKey: key) as! String
            idd = String(describing: id)
        }
        return idd
    }
    
    func filterStringNull(txt: Any) -> String {
        let str = "\(txt)"
        if (str.isEmpty) {
            return ""
        }
        if str.isEqual(nil)  {
            return ""
        }
        if (str == "(null)") {
            return ""
        }
        if (str == "(NULL)") {
            return ""
        }
        if (str == "null") {
            return ""
        }
        if str.isEqual(NSNull()) {
            return ""
        }
        //        if (str.lowercased() as String).rangeOf("null", options: .regularExpression).location != NSNotFound {
        //            return ""
        //        }
        return str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}


extension UIApplication {
    
    class var topViewController: UIViewController? {
        return getTopViewController()
    }
    
    private class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}


extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

public extension UIWindow {
    var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
    }
    
    static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}

