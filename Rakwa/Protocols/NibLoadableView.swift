//
//  NibLoadableView.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import UIKit
 protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
