//
//  UnderLineTF.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

 
import UIKit

@IBDesignable
final class UnderLineTF: UITextField {
  
 
    override func draw(_ rect: CGRect) {
        self.addLine(position: .bottom, color: UIColor(color: .textSecondary)!, width: 1)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .center
//        self.addLine(position: .bottom, color: UIColor(color: .textSecondary), width: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.textAlignment = .center
        
//        self.addLine(position: .bottom, color: UIColor(color: .textSecondary), width: 1)
    }
    
    
}
enum LinePosition {
    case top
    case bottom
}

extension UIView {
    func addLine(position: LinePosition, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .top:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .bottom:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}
