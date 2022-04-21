//
//  TableViewHelper.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

import Foundation
import UIKit
 
 
extension UITableView{
 
    func register<T:UITableViewCell>(_ class:T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
//        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }
}
