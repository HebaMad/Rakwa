//
//  AlertsPresenting.swift
//  Rakwa
//
//  Created by moumen isawe on 07/09/2021.
//

 import UIKit
protocol AlertsPresenting: UIViewController {
}

extension AlertsPresenting {
    func showAlert(title: String?, message: String?) {

        assert((title ?? message) != nil, "Title OR message must be passed in")

        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(ac, animated: true)
    }
   
}
