//
//  UIButtonDesignable.swift
//  Notes
//
//  Created by Momen Reyad Sisalem on 3/6/20.
//  Copyright © 2020 Momen Reyad Sisalem. All rights reserved.
//

import UIKit

@IBDesignable
class UIButtonDesignable: UIButton {
    
    @IBInspectable var bgColor: UIColor = UIColor.white
    
    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.black
    
    @IBInspectable var shadowRadius: CGFloat = 0
    @IBInspectable var shadowColor: UIColor = UIColor.gray
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    @IBInspectable var shadowOpacity: Float = 0
    @IBInspectable var topLeftCorner: CGFloat = 0
    @IBInspectable var bottomLeftCorner: CGFloat = 0
    @IBInspectable var topRightCorner: CGFloat = 0
    @IBInspectable var bottomRightCorner: CGFloat = 0
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.backgroundColor = bgColor.cgColor
        
        layer.cornerRadius = cornerRadius
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        setCustomCorners()
    }
    
    private  func setCustomCorners() {
        
        
        let minx = self.layer.bounds.minX
        let miny = self.layer.bounds.minY
        let maxx = self.layer.bounds.maxX
        let maxy = self.layer.bounds.maxY
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: minx + self.topLeftCorner, y: miny))
        
        path.addLine(to: CGPoint(x: maxx - topRightCorner, y: miny))
        path.addArc(withCenter: CGPoint(x: maxx - topRightCorner, y: miny + topRightCorner), radius: topRightCorner, startAngle:CGFloat(3 * (Double.pi/2)), endAngle: 0, clockwise: true)
        
        path.addLine(to: CGPoint(x: maxx, y: maxy - bottomRightCorner))
        path.addArc(withCenter: CGPoint(x: maxx - bottomRightCorner, y: maxy - bottomRightCorner), radius: bottomRightCorner, startAngle: 0, endAngle: CGFloat((Double.pi/2)), clockwise: true)
        
        path.addLine(to: CGPoint(x: minx + bottomLeftCorner, y: maxy))
        path.addArc(withCenter: CGPoint(x: minx + bottomLeftCorner, y: maxy - bottomLeftCorner), radius: bottomLeftCorner, startAngle: CGFloat((Double.pi/2)), endAngle: CGFloat((Double.pi)), clockwise: true)
        
        path.addLine(to: CGPoint(x: minx, y: miny + topLeftCorner))
        path.addArc(withCenter: CGPoint(x: minx + topLeftCorner, y: miny + topLeftCorner), radius: topLeftCorner, startAngle: CGFloat((Double.pi)), endAngle: CGFloat(3 * (Double.pi/2)), clockwise: true)
        path.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
