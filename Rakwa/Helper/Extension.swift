//
//  Extension.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//


import UIKit
extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
extension UIViewController{
    var sceneDelegate:SceneDelegate{
        return (self.view.window?.windowScene?.delegate)! as! SceneDelegate
    }
 
    
    
    func callMobile(mobileNum:String){
            if mobileNum == nil || mobileNum == "" {
            
                showAlert(title: "Error", message: "you should add your phone number")
            }else{
                
            let number = Int(mobileNum)
                let url:NSURL = URL(string: "TEL://\(number!)") as? NSURL ?? NSURL()
                print(url)

            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        }
    
    
    
    
    
    

}
extension UILabel{
    func addLeading(image: UIImage, text:String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        let space = NSMutableAttributedString(string: " ", attributes: [:])
        let string = NSMutableAttributedString(string: text, attributes: [:])
        mutableAttributedString.append(space)
        mutableAttributedString.append(string)
        self.attributedText = mutableAttributedString
    }
}

extension UIScreen{
   static let _width = UIScreen.main.bounds.size.width
   public class var width: CGFloat {
       return _width
   }
   
   static let _height = UIScreen.main.bounds.size.height
   public class var height: CGFloat {
       return _height
   }
   
   static let _scale = UIScreen.main.scale
   public class var scaleValue: CGFloat {
       return _scale
   }
   
   static let _size = UIScreen.main.bounds.size
   public class var size: CGSize {
       return _size
   }}

extension UIView {
func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
if #available(iOS 11, *) {
self.layer.cornerRadius = radius
self.layer.maskedCorners = corners
        } else {
var cornerMask = UIRectCorner()
if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
let mask = CAShapeLayer()
            mask.path = path.cgPath
self.layer.mask = mask
        }
    }
}

extension UIViewController{
    
    
       func convertDateFormater(_ date: String) -> String
           {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
               let date = dateFormatter.date(from: date)
               dateFormatter.dateFormat = "yyyy-MM-dd"
               return  dateFormatter.string(from: date ?? Date())

           }
//    dateFormatter.dateFormat = "LLLL"

    func convertTimeformat(_ date: String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 3)

        dateFormatter.dateFormat = "HH:mm"
        return  dateFormatter.string(from: date ?? Date())

    }
    func showNoLocationVC(){
        let vc = NoLocationVC(nibName: "NoLocationVC", bundle: .main)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func showNoInternetVC(){
        let vc = NoInternetVC(nibName: "NoInternetVC", bundle: .main)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    func showNoRegisted(){
        let vc = NotRegisted.instantiate()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

    func showActionSheet(title: String, message: String, buttonTitle1: String = "Edit", buttonTitle2: String = "Delete", buttonTitle1Style: UIAlertAction.Style = .default, buttonTitle2Style: UIAlertAction.Style = .default, action1 buttonTitle1Action: @escaping (() -> Void), action2 buttonTitle2Action: @escaping (()->Void)) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        let button1 = UIAlertAction.init(title: buttonTitle1, style: buttonTitle1Style) { (action) in
            print("\(buttonTitle1) Button")
            buttonTitle1Action()
        }
        let button2 = UIAlertAction.init(title: buttonTitle2, style: buttonTitle2Style) { (action) in
            print("\(buttonTitle2) Button")
            buttonTitle2Action()
        }
        let button3 = UIAlertAction.init(title: "Cancel", style: .cancel) { (action) in
            
        }
        alert.addAction(button1)
        alert.addAction(button2)

        alert.addAction(button3)
        self.present(alert, animated: true, completion: nil)
    }

    
    
    
}
extension UIView{
    func convertDateFormaterName(_ dates: String) -> (String,String)
        {
            let dateFormatter = DateFormatter()
            let dateFormatterr = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"

            let date = dateFormatter.date(from: dates)
            dateFormatter.dateFormat = "LLLL"
            
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss z"

            let Num = dateFormatterr.date(from: dates)
            dateFormatterr.dateFormat = "dd"

            return  (dateFormatter.string(from: date ?? Date()),dateFormatterr.string(from: Num ?? Date()))

        }
    func convertTimeformat(_ date: String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 3)

        dateFormatter.dateFormat = "HH:mm"
        return  dateFormatter.string(from: date ?? Date())

    }
    func convertDateFormater(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
            let date = dateFormatter.date(from: date)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return  dateFormatter.string(from: date ?? Date())

        }
    
    
    func timeAgo(fullDate:String) -> String {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYY"
        let date = dateFormatter.date(from: fullDate)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1

        return String(format: formatter.string(from: date ?? Date(), to: Date()) ?? "", locale: .current)
    }
    func setBorder(with color:UIColor,width:CGFloat){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    }

extension Date {

    func timeAgo(date:String) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropAll
        formatter.maximumUnitCount = 1
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:date)!
        return String(format: formatter.string(from: date, to: Date()) ?? "", locale: .current)
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.1,
        x: CGFloat = 0,
        y: CGFloat = 0,
        blur: CGFloat = 9,
        spread: CGFloat = 0 )
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}


class LocationPageControl: UIPageControl {

let locationArrow: UIImage = UIImage(named: "pagenotSelect")!
let pageCircle: UIImage = UIImage(named: "pageselect")!

override var numberOfPages: Int {
    didSet {
        updateDots()
    }
}

override var currentPage: Int {
    didSet {
        updateDots()
    }
}

override func awakeFromNib() {
    super.awakeFromNib()
    self.pageIndicatorTintColor = UIColor.clear
    self.currentPageIndicatorTintColor = UIColor.clear
    self.clipsToBounds = false
}

func updateDots() {
    var i = 0
    for view in self.subviews {
        var imageView = self.imageView(forSubview: view)
        if imageView == nil {
            if i == 0 {
                imageView = UIImageView(image: locationArrow)
            } else {
                imageView = UIImageView(image: pageCircle)
            }
            imageView!.center = view.center
            view.addSubview(imageView!)
            view.clipsToBounds = false
        }
        if i == self.currentPage {
            imageView!.alpha = 1.0
        } else {
            imageView!.alpha = 0.5
        }
        i += 1
    }
}

fileprivate func imageView(forSubview view: UIView) -> UIImageView? {
    var dot: UIImageView?
    if let dotImageView = view as? UIImageView {
        dot = dotImageView
    } else {
        for foundView in view.subviews {
            if let imageView = foundView as? UIImageView {
                dot = imageView
                break
            }
        }
    }
    return dot
}
}
   
extension UIApplication {
    func topViewController() -> UIViewController? {
        var topViewController: UIViewController? = nil
        if #available(iOS 13, *) {
            for scene in connectedScenes {
                if let windowScene = scene as? UIWindowScene {
                    for window in windowScene.windows {
                        if window.isKeyWindow {
                            topViewController = window.rootViewController
                        }
                    }
                }
            }
        } else {
            topViewController = keyWindow?.rootViewController
        }
        while true {
            if let presented = topViewController?.presentedViewController {
                topViewController = presented
            } else if let navController = topViewController as? UINavigationController {
                topViewController = navController.topViewController
            } else if let tabBarController = topViewController as? UITabBarController {
                topViewController = tabBarController.selectedViewController
            } else {
                // Handle any other third party container in `else if` if required
                break
            }
        }
        return topViewController
    }
}
