//
//  ReusableView.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import UIKit
protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

